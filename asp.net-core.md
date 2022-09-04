# ASP.NET Core
<!--ts-->
<!--te-->

## Getting started

Create a new VS project with the **ASP.NET Core Web App (Model-View-Controller)** template.

Set up with **Authentication: Individual Accounts** to set up tables for individual users.

Set up .gitignore with `dotnet new gitignore`

## Unit testing

1. Download the **xnuit** package for the solution
1. Right click Solution -> New Project -> XUnit project
1. Write some tests
1. Build solution
1. Run the tests

## Setting up a new Model, controller and database migration

1. Create a new model class under Models
1. Right-click Controllers -> Add -> Controller... -> MVC Controller with views, using Entity Framework
1. Select Model class, DB Context Class = "MyWebApp.Data.ApplicationDbContext"
1. To create the DB Migration, open the Package Manager Console under Tools -> NuGet Package Manager
1. Do `add-migration "initialsetup"`
1. Check out the new DB migration under Data/Migrations
1. Do `update-database` to start the DB migration

## Create a new View

Either

- Right click Views -> Add -> View -> Razor View

Or

- Go inside your controller and create the endpoint. Right-click the method name -> Add View... -> Razor View

## Styling

ASP.NET uses **bootstrap** for styling.

All stylesheets are by default under wwwroot -> css
