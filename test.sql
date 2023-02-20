-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Фев 20 2023 г., 17:50
-- Версия сервера: 10.4.27-MariaDB
-- Версия PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `test`
--

-- --------------------------------------------------------

--
-- Структура таблицы `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Дамп данных таблицы `posts`
--

INSERT INTO `posts` (`id`, `title`, `description`) VALUES
(1, 'Title2', 'asdasdasd'),
(2, 'fsdsfad', 'fsdasfad');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `login` text NOT NULL,
  `password` text NOT NULL,
  `token` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `login`, `password`, `token`) VALUES
(1, 'test', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', 'dsaasd'),
(2, 'mad', '132123', ''),
(3, 'mads', '$2a$10$fBA07HgtLJxlBc9zi/1Luedk3vvQlBV1zXZxXVQKlNnnv6H52aBzK', ''),
(4, 'testds', '$2a$10$rKam/qqDNrCbNg01KR9rd.dQEHUkIiX5oP0FYnb3gequWPf5OqQCq', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2dpbiI6InRlc3RkcyIsInVzZXJJZCI6NCwiaWF0IjoxNjc2OTAyNjg5LCJleHAiOjE2NzY5ODkwODl9.wxf74ELCHMFa6UWcAog4l3OIg3L6FOU0jIeX43M150k'),
(5, 'testfsd', '$2a$10$clgvcQgtr7mUy21UipdGpOvSZ0e2YMtuXxcZx4U1/JR18Qe31i4xS', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2dpbiI6InRlc3Rmc2QiLCJ1c2VySWQiOjUsImlhdCI6MTY3NjkwNDA3MSwiZXhwIjoxNjc2OTkwNDcxfQ.Wg1SbSy4y2vQO4BihZcJYAFnTEYfRSY8hlw_63en2Hk'),
(6, 'test123', '$2a$10$ijWaJodShLqspdiAeVnVA.2e15ONUA51S2g8E9lJKIECo9gXtxphS', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2dpbiI6InRlc3QxMjMiLCJ1c2VySWQiOjYsImlhdCI6MTY3NjkxMTIwOSwiZXhwIjoxNjc2OTk3NjA5fQ.vZ5dX06VEbrAXTj1XV9hkhX_mH5OO10ILhUcRIYqHqA');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
