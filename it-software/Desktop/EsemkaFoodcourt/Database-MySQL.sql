CREATE DATABASE `EsemkaFoodcourt`
USE `EsemkaFoodcourt`;


CREATE TABLE `Roles` (
	`ID`					INT				NOT NULL	AUTO_INCREMENT	PRIMARY KEY,
	`Name`					VARCHAR(200)	NOT NULL
);


CREATE TABLE `Users` (
	`ID`					INT				NOT NULL	AUTO_INCREMENT	PRIMARY KEY,
	`FirstName`				VARCHAR(200)	NOT NULL,	
	`LastName`				VARCHAR(200)	NOT NULL,
	`Email`					VARCHAR(200)	NOT NULL,
	`PhoneNumber`			VARCHAR(200)	NOT NULL,
	`Password`				VARCHAR(200)	NOT NULL,
	`DateJoined`			DATETIME(3)		NOT NULL,
	`RoleID`				INT				NOT NULL,

	CONSTRAINT FK_Roles_User_RoleID FOREIGN KEY (`RoleID`) REFERENCES `Roles`(`ID`)
);


CREATE TABLE `Categories` (
	`ID`					INT				NOT NULL	AUTO_INCREMENT	PRIMARY KEY,
	`Name`					VARCHAR(200)	NOT NULL
);


CREATE TABLE `Ingredients` (
	`ID`					INT				NOT NULL	AUTO_INCREMENT	PRIMARY KEY,
	`Name`					VARCHAR(200)	NOT NULL
);


CREATE TABLE `Units` (
	`ID`					INT				NOT NULL	AUTO_INCREMENT	PRIMARY KEY,
	`Name`					VARCHAR(200)	NOT NULL
);


CREATE TABLE `Menus` (
	`ID`					INT				NOT NULL	AUTO_INCREMENT	PRIMARY KEY,
	`CategoryID`			INT				NOT NULL,
	`Name`					VARCHAR(200)	NOT NULL,
	`Description`			LONGTEXT			NOT NULL,
	`Price`					DOUBLE			NOT NULL,

	CONSTRAINT FK_Categories_Menu_CategoryID FOREIGN KEY (`CategoryID`) REFERENCES `Categories`(`ID`)
);


CREATE TABLE `MenuIngredients` (
	`ID`					INT				NOT NULL	AUTO_INCREMENT	PRIMARY KEY,
	`MenuID`				INT				NOT NULL,
	`IngredientID`			INT				NOT NULL,
	`UnitID`				INT				NOT NULL,
	`Qty`					INT				NOT NULL,

	CONSTRAINT FK_Menus_MenuIngredient_MenuID FOREIGN KEY (`MenuID`) REFERENCES `Menus`(`ID`),
	CONSTRAINT FK_Ingredients_MenuIngredient_IngredientID FOREIGN KEY (`IngredientID`) REFERENCES `Ingredients`(`ID`),
	CONSTRAINT FK_Units_MenuIngredient_UnitID FOREIGN KEY (`UnitID`) REFERENCES `Units`(`ID`)
);


CREATE TABLE `Tables` (
	`ID`					INT				NOT NULL	AUTO_INCREMENT	PRIMARY KEY,
	`Name`					VARCHAR(200)	NOT NULL
);


CREATE TABLE `Reservations` (
	`ID`					INT				NOT NULL	AUTO_INCREMENT	PRIMARY KEY,
	`UserID`				INT				NOT NULL,
	`CustomerFirstName`		VARCHAR(200)	NOT NULL,		
	`CustomerLastName`		VARCHAR(200)	NOT NULL,
	`CustomerEmail`			VARCHAR(200)	NOT NULL,
	`CustomerPhoneNumber`	VARCHAR(200)	NOT NULL,
	`NumberOfPeople`		INT				NOT NULL,
	`TableID`				INT				NOT NULL,
	`ReservationDate`		DATE			NOT NULL,

	CONSTRAINT FK_Users_Reservation_UserID FOREIGN KEY (`UserID`) REFERENCES `Users`(`ID`),
	CONSTRAINT FK_Tables_Reservation_TableID FOREIGN KEY (`TableID`) REFERENCES `Tables`(`ID`)
);


CREATE TABLE `ReservationDetails` (
	`ID`					INT				NOT NULL	AUTO_INCREMENT	PRIMARY KEY,
	`ReservationID`			INT				NOT NULL,
	`MenuID`				INT				NOT NULL,
	`Qty`					INT				NOT NULL,

	CONSTRAINT FK_Reservations_ReservationDetail_ReservationID FOREIGN KEY (`ReservationID`) REFERENCES `Reservations`(`ID`),
	CONSTRAINT FK_Menus_ReservationDetail_MenuID FOREIGN KEY (`MenuID`) REFERENCES `Menus`(`ID`)
);



INSERT INTO `Roles` (Name) VALUES ('Admin');

INSERT INTO `Roles` (Name) VALUES ('Member');



INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Lavena', 'Schwant', 'lschwant0@europa.eu', 'uM1%g)Aq0', '081046774606', '2001-06-01');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Lil', 'Mapplebeck', 'lmapplebeck1@slashdot.org', 'xX0~ha1d>k!I"{o', '083076891362', '2003-08-02');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Cleavland', 'Hadaway', 'chadaway2@globo.com', 'rB9|/0<`', '087942165404', '2004-05-05');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Waylan', 'Jaegar', 'wjaegar3@omniture.com', 'pO2)*''uon', '087639048951', '2004-08-23');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Nelson', 'Firbanks', 'nfirbanks4@slate.com', 'bT9,6J643', '086267583989', '2003-04-05');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Eugine', 'Noblet', 'enoblet5@google.co.jp', 'mQ8`U>uQ*x', '085967453568', '2003-10-29');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Tomkin', 'Piccop', 'tpiccop6@princeton.edu', 'hZ8=jxGpNV,"xL%', '086601132923', '2003-12-22');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Carolan', 'O''Brian', 'cobrian7@bizjournals.com', 'zS3`+6,G1I~', '084125449330', '2002-07-18');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Madelon', 'Mingey', 'mmingey8@infoseek.co.jp', 'bB5''L+V@*KcI+Y', '088989736400', '2005-04-08');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Morry', 'Shotbolt', 'mshotbolt9@eepurl.com', 'wV4*O<5i', '085301952355', '2002-09-30');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Tad', 'Jerschke', 'tjerschkea@reference.com', 'oU7(2?kl1Qzn>', '085188912754', '2000-09-14');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Cass', 'Newsome', 'cnewsomeb@google.ca', 'jN8.0vYP)s0W2Qo', '086925471247', '2005-03-05');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Conrad', 'Tomisch', 'ctomischc@shinystat.com', 'rT0~<G=Q*', '086066945390', '2002-11-03');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Randal', 'Tames', 'rtamesd@youtube.com', 'pZ9%v|"iT4''3A*v~', '086486669858', '2001-07-30');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Hildagarde', 'Robben', 'hrobbene@ameblo.jp', 'kB8}JaDF+|4v~au', '087749441544', '2001-05-16');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Madelene', 'Tremathick', 'mtremathickf@technorati.com', 'mS3@t9lt', '082538016101', '2002-11-14');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Roberta', 'Lumsden', 'rlumsdeng@e-recht24.de', 'nZ2@ADa)>r62dlWn', '084996827349', '2005-06-12');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Eric', 'Blenkiron', 'eblenkironh@salon.com', 'tV9>y''Eg9grlPb', '085993897675', '2004-05-08');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Merrick', 'Rodders', 'mroddersi@mozilla.com', 'rT4<v*nQ)>)/NY@', '082102690960', '2004-05-12');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Bertina', 'Tilzey', 'btilzeyj@so-net.ne.jp', 'eR3#j2st${4s5my8', '087231146818', '2002-09-09');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Herschel', 'Misselbrook', 'hmisselbrookk@cocolog-nifty.com', 'vR9?E_Ak9sz%Yt$', '086264436216', '2005-02-28');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Dotti', 'Cussons', 'dcussonsl@tumblr.com', 'yY6<$?tE', '088565891530', '2001-01-08');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Delila', 'Lamden', 'dlamdenm@apple.com', 'qC1$oSd%93*d', '081115584370', '2005-01-20');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Mireielle', 'Claypool', 'mclaypooln@e-recht24.de', 'vI4`oL+2UtVKF''8', '087029491409', '2005-06-30');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Cammie', 'Byass', 'cbyasso@last.fm', 'qI3_W{/y>xY?@X', '085911938265', '2001-08-20');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Abbey', 'Webbe', 'awebbep@wikipedia.org', 'yP6=gKIGp', '088733096118', '2004-12-13');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Mollee', 'Rosson', 'mrossonq@nydailynews.com', 'wR3%o*>rKO1', '086158840169', '2005-07-27');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Jenilee', 'Bettleson', 'jbettlesonr@xing.com', 'hC7&*l*11$rq', '089422481310', '2004-06-29');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (2, 'Louise', 'Saenz', 'lsaenzs@discovery.com', 'jX5(OqY+_LD5eYK4', '083566717626', '2002-08-07');

INSERT INTO `Users` (RoleID, FirstName, LastName, Email, Password, PhoneNumber, DateJoined) VALUES (1, 'Dusty', 'Ganny', 'dgannyt@squidoo.com', 'dN1|qg!,xuZ', '083331608296', '2003-03-09');




INSERT INTO `Categories` (Name) VALUES ('Breakfast');

INSERT INTO `Categories` (Name) VALUES ('Dinner');

INSERT INTO `Categories` (Name) VALUES ('Lunch');

INSERT INTO `Categories` (Name) VALUES ('Dessert');

INSERT INTO `Categories` (Name) VALUES ('Salad');

INSERT INTO `Categories` (Name) VALUES ('Snack');

INSERT INTO `Categories` (Name) VALUES ('Soup');

INSERT INTO `Categories` (Name) VALUES ('Vegetarian Dishes');

INSERT INTO `Categories` (Name) VALUES ('Hamburgers');

INSERT INTO `Categories` (Name) VALUES ('Healthy');



INSERT INTO `Ingredients` (Name) VALUES
('Flour'),
('Sugar'),
('Salt'),
('Butter'),
('Eggs'),
('Milk'),
('Vanilla extract'),
('Baking powder'),
('Chocolate chips'),
('Olive oil'),
('Onion'),
('Garlic'),
('Tomatoes'),
('Basil'),
('Parmesan cheese'),
('Ground beef'),
('Chicken breasts'),
('Lettuce'),
('Cucumber'),
('Bell pepper'),
('Pasta'),
('Rice'),
('Black beans'),
('Cheddar cheese'),
('Sour cream'),
('Avocado'),
('Lime'),
('Cilantro'),
('Ground turkey'),
('Bacon'),
('Peanut butter'),
('Jelly'),
('Bread'),
('Mayonnaise'),
('Mustard'),
('Ketchup'),
('Pickles'),
('Hot sauce'),
('Soy sauce'),
('Ginger'),
('Honey'),
('Brown sugar'),
('Cinnamon'),
('Nutmeg'),
('Paprika');


INSERT INTO `Units` (Name) VALUES ('Tablespoon');

INSERT INTO `Units` (Name) VALUES ('Teaspoon');

INSERT INTO `Units` (Name) VALUES ('Cup');

INSERT INTO `Units` (Name) VALUES ('Pint');

INSERT INTO `Units` (Name) VALUES ('Gallon');

INSERT INTO `Units` (Name) VALUES ('Liter');

INSERT INTO `Units` (Name) VALUES ('Ounce');

INSERT INTO `Units` (Name) VALUES ('Gram');

INSERT INTO `Units` (Name) VALUES ('Kilogram');



INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (1, 'Zucchini fritters', 'Served with a poached egg on top, zucchini fritters make an easy carb-free breakfast.', 150000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (1, 'Dark chocolate cranberry scones', 'Dark chocolate and dried cranberries combine for a decadent weekend scone.', 75000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (1, 'Three-minute breakfast tortilla', 'A simple basted egg on a tortilla with a side of sliced avocado will jump-start your morning the right way.', 60000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (1, 'Classic Pancakes', 'Fluffy and delicious pancakes served with maple syrup and butter.', 120000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (1, 'Fruit Parfait', 'Layers of yogurt, granola, and assorted fresh fruits for a healthy and refreshing breakfast.', 90000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (1, 'Eggs Benedict', 'Poached eggs on English muffins topped with hollandaise sauce and Canadian bacon.', 180000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (1, 'Homemade Granola Bars', 'Nutritious granola bars made with oats, nuts, and dried fruits.', 75000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (1, 'Avocado Toast', 'Toasted bread topped with mashed avocado, salt, pepper, and a drizzle of olive oil.', 60000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (1, 'Greek Yogurt Parfait', 'Creamy Greek yogurt layered with honey, granola, and mixed berries.', 90000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (1, 'Banana Walnut Muffins', 'Moist and nutty muffins made with ripe bananas and chopped walnuts.', 75000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (1, 'Omelette with Spinach and Feta', 'Fluffy omelette filled with sautéed spinach and crumbled feta cheese.', 105000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (1, 'Blueberry Pancakes', 'Pancakes studded with fresh blueberries and served with a blueberry compote.', 135000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (1, 'Healthy Breakfast Burrito', 'Whole wheat tortilla filled with scrambled eggs, black beans, veggies, and salsa.', 120000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (1, 'Cinnamon French Toast', 'Thick slices of bread dipped in a cinnamon-infused egg mixture and pan-fried.', 90000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (1, 'Smoked Salmon Bagel', 'Toasted bagel topped with cream cheese, smoked salmon, red onion, and capers.', 150000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (2, 'Baked Salmon', 'Salmon fillet seasoned and baked to perfection, served with steamed vegetables.', 180000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (2, 'Pasta Primavera', 'Pasta tossed with a medley of fresh vegetables and a light garlic sauce.', 135000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (2, 'Stuffed Bell Peppers', 'Bell peppers stuffed with a flavorful mixture of rice, beans, and vegetables.', 120000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (2, 'Chicken and Broccoli Stir-Fry', 'Sliced chicken breast and broccoli florets stir-fried in a savory sauce.', 150000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (2, 'Spaghetti Carbonara', 'Classic Italian pasta dish made with eggs, cheese, pancetta, and black pepper.', 135000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (3, 'Caprese Salad', 'Fresh mozzarella, tomatoes, and basil drizzled with balsamic glaze.', 105000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (3, 'Vegetable Stir-Fry', 'Assorted vegetables stir-fried with tofu and a flavorful sauce.', 120000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (3, 'Mediterranean Wrap', 'Whole wheat wrap filled with hummus, roasted vegetables, and feta cheese.', 105000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (3, 'Quinoa Salad with Chickpeas', 'Quinoa salad loaded with chickpeas, vegetables, and a tangy dressing.', 90000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (3, 'Grilled Cheese Sandwich', 'Classic grilled cheese sandwich with melted cheddar on toasted bread.', 75000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (4, 'Chocolate Lava Cake', 'Rich and decadent chocolate cake with a gooey molten center.', 120000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (4, 'Berry Parfait', 'Layers of fresh berries, yogurt, and granola for a delightful dessert.', 90000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (5, 'Fruit Salad', 'Assorted fresh fruits tossed in a citrus dressing for a light and refreshing breakfast.', 90000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (6, 'Homemade Trail Mix', 'A mix of nuts, dried fruits, and chocolate chips for a satisfying snack.', 60000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (6, 'Crispy Chickpeas', 'Roasted chickpeas seasoned with your favorite spices for a crunchy snack.', 45000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (6, 'Greek Yogurt Dip', 'Creamy Greek yogurt mixed with herbs and garlic for a healthy dip.', 75000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (6, 'Vegetable Spring Rolls', 'Fresh spring rolls filled with colorful vegetables and served with dipping sauce.', 90000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (7, 'Creamy Tomato Basil Soup', 'Smooth and rich tomato soup with fresh basil and a touch of cream.', 90000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (7, 'Lentil Soup', 'Hearty and nutritious soup made with lentils, vegetables, and aromatic spices.', 75000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (7, 'Minestrone Soup', 'Classic Italian soup with a medley of vegetables, beans, pasta, and savory broth.', 105000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (8, 'Mushroom and Spinach Quesadilla', 'Sautéed mushrooms and spinach with melted cheese in a crispy tortilla.', 90000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (8, 'Chickpea and Vegetable Stir-Fry', 'Stir-fried chickpeas and assorted vegetables in a flavorful sauce, served over rice.', 105000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (9, 'Classic Cheeseburger', 'Juicy beef patty topped with melted cheese, lettuce, tomato, and pickles.', 150000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (9, 'Veggie Burger', 'Homemade vegetarian patty made with beans, veggies, and spices, served on a bun.', 120000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (9, 'BBQ Bacon Burger', 'Grilled beef patty topped with crispy bacon and smoky barbecue sauce.', 180000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (9, 'Mushroom Swiss Burger', 'Beef patty topped with sautéed mushrooms and melted Swiss cheese.', 135000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (9, 'Spicy Jalapeno Burger', 'Beef patty topped with sliced jalapenos, pepper jack cheese, and spicy mayo.', 150000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (10, 'Grilled Chicken Salad', 'Grilled chicken breast served on a bed of mixed greens with assorted veggies.', 120000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (10, 'Quinoa and Avocado Bowl', 'Cooked quinoa topped with avocado slices, black beans, corn, and lime dressing.', 105000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (10, 'Roasted Vegetable Wrap', 'Roasted vegetables and hummus wrapped in a whole wheat tortilla.', 90000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (10, 'Greek Chickpea Salad', 'Chickpeas, tomatoes, cucumbers, red onion, and feta cheese in a lemon vinaigrette.', 105000);

INSERT INTO `Menus` (CategoryID, Name, Description, Price) VALUES (10, 'Salmon and Quinoa Bowl', 'Grilled salmon fillet served with cooked quinoa and steamed vegetables.', 150000);



INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (1, 8, 9, 30);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (1, 1, 4, 59);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (1, 36, 3, 51);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (1, 22, 5, 75);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (1, 13, 5, 29);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (2, 41, 9, 2);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (2, 5, 1, 43);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (2, 31, 9, 63);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (2, 8, 3, 60);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (2, 13, 2, 56);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (3, 29, 1, 39);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (3, 12, 2, 16);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (3, 31, 5, 34);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (3, 31, 4, 64);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (3, 42, 8, 27);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (4, 28, 7, 2);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (4, 32, 3, 82);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (4, 28, 7, 89);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (4, 28, 2, 43);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (4, 8, 6, 76);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (5, 22, 2, 54);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (5, 3, 9, 73);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (5, 12, 2, 92);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (5, 19, 3, 87);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (5, 22, 2, 7);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (6, 22, 7, 21);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (6, 7, 2, 10);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (6, 11, 9, 17);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (6, 31, 4, 42);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (6, 11, 6, 70);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (7, 11, 5, 46);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (7, 28, 4, 40);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (7, 20, 2, 43);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (7, 30, 1, 73);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (7, 17, 5, 79);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (8, 19, 4, 72);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (8, 34, 8, 93);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (8, 34, 2, 49);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (8, 37, 9, 68);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (8, 40, 5, 62);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (9, 36, 5, 66);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (9, 35, 8, 12);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (9, 43, 3, 46);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (9, 14, 2, 58);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (9, 36, 6, 73);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (10, 30, 5, 67);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (10, 23, 4, 76);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (10, 12, 3, 21);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (10, 7, 1, 12);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (10, 20, 1, 7);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (11, 17, 1, 52);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (11, 12, 5, 93);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (11, 18, 7, 21);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (11, 17, 9, 91);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (11, 29, 9, 64);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (12, 7, 9, 75);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (12, 16, 3, 17);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (12, 36, 3, 75);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (12, 11, 4, 96);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (12, 19, 3, 48);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (13, 17, 2, 98);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (13, 44, 8, 83);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (13, 3, 2, 68);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (13, 8, 1, 32);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (13, 2, 4, 22);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (14, 5, 2, 68);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (14, 15, 4, 83);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (14, 40, 3, 25);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (14, 9, 9, 41);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (14, 8, 2, 77);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (15, 9, 1, 48);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (15, 33, 7, 76);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (15, 12, 7, 63);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (15, 30, 3, 75);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (15, 38, 6, 82);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (16, 8, 7, 84);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (16, 29, 8, 61);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (16, 45, 6, 89);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (16, 12, 7, 22);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (16, 38, 1, 11);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (17, 19, 9, 26);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (17, 24, 6, 39);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (17, 14, 7, 74);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (17, 8, 9, 93);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (17, 27, 6, 10);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (18, 10, 8, 64);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (18, 9, 3, 3);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (18, 22, 7, 99);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (18, 7, 9, 69);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (18, 28, 3, 7);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (19, 9, 6, 49);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (19, 22, 3, 33);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (19, 32, 1, 68);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (19, 38, 1, 49);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (19, 29, 7, 7);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (20, 23, 3, 20);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (20, 32, 1, 59);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (20, 24, 5, 86);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (20, 7, 2, 94);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (20, 11, 7, 21);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (21, 36, 2, 92);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (21, 5, 2, 44);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (21, 23, 4, 77);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (21, 12, 4, 87);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (21, 30, 8, 6);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (22, 33, 8, 17);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (22, 25, 5, 90);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (22, 1, 7, 98);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (22, 13, 6, 13);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (22, 10, 3, 54);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (23, 34, 5, 100);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (23, 8, 4, 20);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (23, 39, 1, 71);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (23, 45, 5, 36);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (23, 29, 4, 17);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (24, 35, 6, 48);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (24, 40, 8, 36);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (24, 11, 5, 41);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (24, 38, 1, 29);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (24, 27, 6, 75);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (25, 24, 3, 77);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (25, 18, 5, 88);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (25, 33, 4, 95);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (25, 29, 9, 62);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (25, 21, 6, 3);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (26, 39, 9, 88);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (26, 37, 6, 63);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (26, 3, 4, 58);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (26, 44, 2, 41);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (26, 34, 1, 90);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (27, 45, 5, 88);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (27, 28, 2, 72);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (27, 40, 8, 85);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (27, 41, 1, 54);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (27, 26, 1, 98);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (28, 26, 7, 69);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (28, 1, 3, 19);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (28, 18, 9, 2);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (28, 27, 8, 32);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (28, 36, 3, 5);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (29, 29, 1, 79);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (29, 20, 8, 66);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (29, 44, 3, 92);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (29, 2, 1, 5);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (29, 4, 6, 45);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (30, 10, 1, 89);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (30, 23, 6, 87);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (30, 1, 8, 27);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (30, 8, 5, 36);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (30, 10, 2, 72);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (31, 35, 9, 58);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (31, 19, 1, 15);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (31, 38, 9, 87);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (31, 15, 8, 98);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (31, 4, 8, 47);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (32, 11, 2, 77);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (32, 19, 3, 47);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (32, 38, 4, 23);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (32, 17, 4, 40);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (32, 31, 4, 78);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (33, 37, 6, 47);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (33, 45, 9, 82);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (33, 36, 8, 71);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (33, 45, 1, 5);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (33, 43, 7, 29);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (34, 8, 4, 37);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (34, 44, 6, 20);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (34, 23, 6, 49);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (34, 19, 1, 75);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (34, 45, 4, 36);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (35, 21, 2, 45);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (35, 29, 1, 2);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (35, 22, 6, 99);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (35, 6, 4, 71);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (35, 39, 8, 73);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (36, 11, 4, 39);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (36, 11, 4, 69);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (36, 39, 1, 33);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (36, 11, 5, 29);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (36, 12, 8, 85);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (37, 20, 5, 59);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (37, 17, 6, 41);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (37, 18, 6, 69);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (37, 31, 9, 44);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (37, 12, 5, 98);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (38, 19, 4, 45);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (38, 11, 4, 15);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (38, 20, 8, 26);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (38, 40, 4, 29);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (38, 38, 3, 1);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (39, 15, 5, 55);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (39, 39, 1, 88);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (39, 45, 7, 80);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (39, 19, 1, 65);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (39, 41, 8, 7);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (40, 37, 1, 51);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (40, 2, 2, 45);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (40, 28, 4, 12);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (40, 27, 7, 40);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (40, 15, 2, 98);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (41, 33, 4, 54);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (41, 12, 1, 88);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (41, 15, 6, 32);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (41, 42, 2, 37);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (41, 28, 3, 65);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (42, 23, 7, 74);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (42, 19, 6, 31);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (42, 20, 3, 58);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (42, 35, 5, 69);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (42, 11, 7, 72);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (43, 31, 8, 21);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (43, 41, 8, 28);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (43, 14, 7, 86);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (43, 21, 7, 29);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (43, 29, 7, 75);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (44, 27, 3, 42);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (44, 29, 2, 6);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (44, 30, 8, 75);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (44, 37, 6, 22);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (44, 13, 8, 94);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (45, 38, 3, 83);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (45, 41, 2, 65);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (45, 39, 8, 95);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (45, 40, 8, 7);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (45, 23, 5, 91);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (46, 38, 7, 28);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (46, 10, 2, 75);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (46, 22, 2, 31);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (46, 10, 1, 78);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (46, 16, 9, 38);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (47, 30, 1, 79);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (47, 17, 9, 44);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (47, 40, 9, 81);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (47, 12, 1, 54);

INSERT INTO `MenuIngredients` (MenuID, IngredientID, UnitID, Qty) VALUES (47, 6, 2, 30);


INSERT INTO `Tables` (Name) VALUES ('Table 1');

INSERT INTO `Tables` (Name) VALUES ('Table 2');

INSERT INTO `Tables` (Name) VALUES ('Table 3');

INSERT INTO `Tables` (Name) VALUES ('Table 4');

INSERT INTO `Tables` (Name) VALUES ('Table 5');

INSERT INTO `Tables` (Name) VALUES ('Table 6');

INSERT INTO `Tables` (Name) VALUES ('Table 7');

INSERT INTO `Tables` (Name) VALUES ('Table 8');

INSERT INTO `Tables` (Name) VALUES ('Table 9');

INSERT INTO `Tables` (Name) VALUES ('Table 10');

INSERT INTO `Tables` (Name) VALUES ('Table 11');

INSERT INTO `Tables` (Name) VALUES ('Table 12');


INSERT INTO `Reservations` (UserID, CustomerFirstName, CustomerLastName, CustomerEmail, CustomerPhoneNumber, NumberOfPeople, TableID, ReservationDate) VALUES (1, 'Lavena', 'Schwant', 'lschwant0@europa.eu', '081046774606', 4, 1, '2023-08-16');

INSERT INTO `Reservations` (UserID, CustomerFirstName, CustomerLastName, CustomerEmail, CustomerPhoneNumber, NumberOfPeople, TableID, ReservationDate) VALUES (1, 'Andrew', 'Gabriel Foo', 'andre@gmail.com', '081234567890', 2, 8, '2023-08-16');


INSERT INTO `ReservationDetails` (ReservationID, MenuID, Qty) VALUES (1, 14, 6);

INSERT INTO `ReservationDetails` (ReservationID, MenuID, Qty) VALUES (1, 9, 3);

INSERT INTO `ReservationDetails` (ReservationID, MenuID, Qty) VALUES (1, 27, 7);

INSERT INTO `ReservationDetails` (ReservationID, MenuID, Qty) VALUES (1, 22, 6);

INSERT INTO `ReservationDetails` (ReservationID, MenuID, Qty) VALUES (1, 32, 10);

INSERT INTO `ReservationDetails` (ReservationID, MenuID, Qty) VALUES (2, 46, 9);

INSERT INTO `ReservationDetails` (ReservationID, MenuID, Qty) VALUES (2, 8, 1);

INSERT INTO `ReservationDetails` (ReservationID, MenuID, Qty) VALUES (2, 41, 4);