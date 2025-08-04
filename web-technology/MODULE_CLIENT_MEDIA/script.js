document.getElementById('home').style.display = 'block';
document.getElementById('button-instruction').addEventListener('click', function(event) {
    event.preventDefault();
    document.getElementById('home').style.display = 'none';
    document.getElementById('instruction').style.display = 'block';
});

document.getElementById('cross-instruction').addEventListener('click', function() {
    document.getElementById('instruction').style.display = 'none';
    document.getElementById('home').style.display = 'block';
});

