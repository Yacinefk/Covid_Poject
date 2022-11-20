-- Looking at total cases vs Total deaths
select location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage
from covid_deaths
where continent is not null
order by 1,2

-- Total cases vs population
-- Show the percentage of population got infedcted by covid
select location, date, population, total_cases, (total_cases / population) * 100 as InfectedPopulationPercentage
from covid_deaths

order by 1,2


-- Total cases vs population
-- Show the percentage of population got infedcted by covid
select location, population, max(total_cases) as HighestInfectionCount, max((total_cases / population) * 100) as InfectedPopulationPercentage
from covid_deaths
group by location, population
order by 4 desc

-- Countries with the Highest Death count per population
select location, max(cast (total_deaths as int)) as TotalDeathCount
from covid_deaths
where continent is not null
group by location
order by TotalDeathCount desc


-- Let's break things down by continent
-- Countries with the Highest Death count per Continent
select location, max(cast (total_deaths as int)) as TotalDeathCount
from covid_deaths
where continent is null
group by location
order by TotalDeathCount desc


-- Global Numbers
SELECT date, SUM(new_cases) as TotalCases, SUM(new_deaths) as TotalDeaths, 
ROUND(SUM(new_deaths)/sum(new_cases) * 100,2) as DeathPercentage
FROM Covid_Deaths
where continent is not null
group by date
order by 1,2

-- Global Numbers
SELECT SUM(new_cases) as TotalCases, SUM(new_deaths) as TotalDeaths, 
ROUND(SUM(new_deaths)/sum(new_cases) * 100,2) as DeathPercentage
FROM Covid_Deaths
where continent is not null
--group by date
order by 1,2

-- Looking at Total population vs Vaccinations
SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations,
SUM(new_vaccinations) 
                 OVER (PARTITION BY d.location order by d.location,d.date ) as RollingPeopleVaccinated
FROM covid_vaccination v
   JOIN Covid_deaths d
   ON d.location = v.location
   AND v.date=d.date
where d.continent is not null
order by 1,2


--USE CTE to get the percentage