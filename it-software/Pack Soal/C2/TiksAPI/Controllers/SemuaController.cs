using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using Microsoft.Extensions.ObjectPool;
using System.Diagnostics;

namespace TiksAPI.Controllers
{
    [Route("api")]
    [ApiController]
    public class SemuaController(TiksIdContext context) : ControllerBase
    {
        public class AuthRequest
        {
            public string Email { get; set; }
            public string Password { get; set; }
        }

        [HttpPost("Login")]
        public IActionResult Auth(AuthRequest req)
        {
            var user = context.Users.FirstOrDefault(e => e.Email == req.Email && e.Password == req.Password);

            if (user == default) return Unauthorized();
            return Ok(user);
        }

        [HttpGet("Home/PreviewMovie")]
        public IActionResult PreviewMovie()
        {
            var movie = context.Movies.Include(e => e.MovieGenres).ThenInclude(e => e.Genre).Include(e => e.Schedules).ThenInclude(e => e.Transactions).FirstOrDefault();
            if (movie != default)
            {
                movie = context.Movies.OrderByDescending(e => e.ReleaseDate).Include(e => e.MovieGenres).ThenInclude(e => e.Genre).First();
            }

            return Ok(new
            {
                ID = movie.Id,
                Title = movie.Title,
                Duration = movie.Duration,
                Genre = movie.MovieGenres.OrderBy(e => e.Genre.Name).First().Genre.Name
            });
        }


        [HttpGet("Home/NewMovies")]
        public IActionResult NewMovies()
        {
            var movies = context.Movies.OrderByDescending(e => e.ReleaseDate).Select(e => new
            {
                ID = e.Id,
                Title = e.Title,
                Duration = e.Duration,
                Genre = e.MovieGenres.OrderBy(f => f.Genre.Name).First().Genre.Name,
            }).ToList();
            return Ok(movies);
        }

        [HttpGet("Movie/{id}/Photo")]
        public IActionResult Photo(int id)
        {
            var movie = context.Movies.Find(id);

            if (movie == null) return NotFound();

            var dir = Path.Combine(Environment.CurrentDirectory, "Photos", movie.Poster);
            var file = new FileStream(dir, FileMode.Open);
            return File(file, "image/*");
        }

        public class BuyRequest
        {
            public int User { get; set; }
            public int Schedule { get; set; }
            public string[] Seats { get; set; }
        }

        [HttpPost("Buy")]
        public IActionResult Buy(BuyRequest req)
        {
            var transaction = new Transaction
            {
                ScheduleId = req.Schedule,
                TransactionDate = DateTime.Now,
                UserId = req.User,
            };
            var schedule = context.Schedules.Find(req.Schedule);
            foreach (var seat in req.Seats)
            {
                transaction.TransactionDetails.Add(new TransactionDetail
                {
                    Price = schedule.Price,
                    Seat = seat,
                });
            }
            context.Transactions.Add(transaction);
            context.SaveChanges();
            return Ok();
        }

        [HttpGet("Movie/{id}")]
        public IActionResult MovieDetail(int id)
        {
            var movie = context.Movies
                .Include(e => e.MovieGenres)
                .ThenInclude(e => e.Genre)
                .Include(e => e.Schedules)
                .ThenInclude(e => e.Theater)
                .Include(e => e.Schedules)
                .ThenInclude(e => e.Transactions)
                .ThenInclude(e => e.TransactionDetails)
                .Where(e => e.Id == id)
                .Select(e => new
                {
                    ID = e.Id,
                    Title = e.Title,
                    Year = e.ReleaseDate.Year,
                    Duration = e.Duration,
                    Genres = e.MovieGenres.Select(e => e.Genre.Name),
                    Description = e.Description,
                    Schedule = e.Schedules.Where(e => e.Transactions.Count() < (e.Theater.Section * e.Theater.Column * e.Theater.Row)).Select(e => new
                    {
                        e.Price,
                        e.Id,
                        Date = e.Date.ToString("ddd dd MMM"),
                        Time = e.Time.ToString("HH:mm"),
                        BookedSeats = e.Transactions.SelectMany(e => e.TransactionDetails.Select(e => e.Seat)),
                        Theater = new
                        {
                            ID = e.TheaterId,
                            e.Theater.Name,
                            e.Theater.Section,
                            e.Theater.Column,
                            e.Theater.Row
                        }
                    }),
                }).First();

            return Ok(movie);
        }

        [HttpGet("Tickets/{id}")]
        public IActionResult Tickets(int id)
        {
            var tickets = context.Transactions
                .Include(e => e.Schedule)
                .ThenInclude(e => e.Movie)
                .Include(e => e.TransactionDetails)
                .Where(e => e.UserId == id)
                .Select(e => new
                {
                    MovieId = e.Schedule.MovieId,
                    Title = e.Schedule.Movie.Title,
                    Count = e.TransactionDetails.Count(),
                    Date = e.Schedule.Date,
                    Seats = string.Join(',', e.TransactionDetails.Select(e => e.Seat)),
                    Price = e.TransactionDetails.Sum(e => e.Price)
                }).ToList();
            return Ok(tickets);
        }
    }
}
