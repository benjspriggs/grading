//Jason Lingel
//CS202
//HW2

//#include "ingredient.h"
//#include "bst.h"
#include "menu.h"
//#include <fstream>
//#include <iostream>




//using namespace std;






int main()
{




	ifstream infile;
	ifstream in_file;

    infile.open("ingredient.txt");

    bst  * tree;
	tree = new bst(infile);


    infile.close();

    in_file.open("menu.txt");

	menu * Menu;
	Menu = new menu(in_file, tree);

    in_file.close();

    int select = 0;

    while(select != 3)
    {


        cout << "Select:"<< endl
        << "1. display menu" << endl
        << "2. display ingredients" << endl 
	<< "3. exit" << endl << endl;

        cin >> select;
	cin.ignore();

        switch(select)
        {
            case 1:
       		Menu->display_meals();                
                break;
            case 2:
     		tree->display_all();

                break;
            case 3:
                break;
        }
}   }

