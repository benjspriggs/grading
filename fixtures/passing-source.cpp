// My name and the class
// Purpose of the program

#include <iostream>
using namespace std;

int main()
{
  // Create variables
  int month, day, year; // today's date

  // Prompt the user for today's date
  cout << "Please enter the month, day, and "
  << "year each separated by a space: "
  << endl;

  /*  cout << "Please enter the month, day, and ";
  cout << "year each separated by a space: ";
  cout << endl; */

  // Read in the month, day and year
  // cin >> month >> day >> year;
  month = 4, day = 2, year = 1995;

  /*cin >> month;
  cin >> day;
  cin >> year; */

  // Echo it back to the user:
  cout << "The month is: " << month << ", ";
  cout << "the day is: " << day << ", and ";
  cout << "the year is: " << year << endl;

  return 0;																
}
