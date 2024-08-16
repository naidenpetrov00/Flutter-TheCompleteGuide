import 'package:expense_tracker/model/expense.dart';

final registeredExpenses = [
  Expense(
    Category.work,
    title: 'Flutter Course',
    amount: 1999,
    date: DateTime.now(),
  ),
  Expense(
    Category.leisure,
    title: 'Movie Night',
    amount: 350,
    date: DateTime.now().subtract(const Duration(days: 3)),
  ),
  Expense(
    Category.food,
    title: 'Groceries',
    amount: 1200,
    date: DateTime.now().subtract(const Duration(days: 7)),
  ),
  Expense(
    Category.travel,
    title: 'Train Ticket',
    amount: 800,
    date: DateTime.now().subtract(const Duration(days: 10)),
  ),
  Expense(
    Category.work,
    title: 'New Laptop Stand',
    amount: 450,
    date: DateTime.now().subtract(const Duration(days: 2)),
  ),
];
