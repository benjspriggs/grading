#include "ingredient.h"
//#include "bst.h"
#include <iostream>
#include <fstream>
#include <cctype>
#include <cstring>
#include <cstdlib>


using namespace std;


ingredient::ingredient()
{


	day = 0;
	month = 0;
	units = 0;

}

ingredient::ingredient(char *in_name, bool in_g, char * g_alt, bool in_d, char * d_alt, bool in_p, char* p_alt, int in_units, int in_day, int in_month)
{
	name = new char[strlen(in_name)];
	strcpy(name, in_name);

	gluten = in_g;
	peanuts = in_p;
	units = in_units;
	day = in_day;
	month = in_month;

	gluten_alt = new char[strlen(g_alt)+1];
	strcpy(gluten_alt, g_alt);

	dairy_alt = new char[strlen(d_alt)+1];
	strcpy(dairy_alt, d_alt);

	peanuts_alt = new char[strlen(p_alt)+1];
	strcpy(peanuts_alt, p_alt);

//	key = create_key(name);
	menu_list * list; 
	list = new menu_list();



}



void ingredient::stock(int amount)
{
	units += amount;
}

void ingredient::order()
{
	--units;
}

void ingredient::add_menu(char * menu_name)
{
	if(list == NULL)
		list = new menu_list(menu_name);
	else
		list->add_node(menu_name);
}

void ingredient::display()
{
	cout << name << endl;
	if(gluten == true)
		cout << "Contains gluten, GF option available" << endl;
	if(dairy == true)
		cout << "Contains dairy, dairy free option available" << endl;
	if(peanuts == true)
		cout << "Contains peanuts, other nuts available" << endl;
	cout << endl;
}


node::node():ingredient()
{
	left = NULL;
	right = NULL;

}

/*node::node(& ingredient):ingredient(ingredient)
{
	left = NULL;
	right = NULL;
}*/


node::node(char *in_name, bool in_g, char * g_alt, bool in_d, char * d_alt, bool in_p, char* p_alt, int in_units, int in_day, int in_month): ingredient(in_name, in_g, g_alt,in_d, d_alt, in_p, p_alt, in_units, in_day, in_month)
{
	left = NULL;
	right = NULL;
}

void node::purchase(int amount)
{
    units += amount;

}

menu_list::menu_list()
{
	head = NULL;
}

menu_list::menu_list(char * menu)
{
	head = new menu_node(menu);
}

void menu_list::add_node(char * menu)
{
		
	menu_node * temp = new menu_node(menu);
	if(head != NULL)
		temp->set_next(head);
	head = temp;
}

void menu_list::display_all()
{
	if(!head)
		return;
	head->display();
	display(head->get_next());
}

void menu_list::display(menu_node * top)
{
	top->display();
	display(top->get_next());
}

menu_node::menu_node(char * menu)
{
	menu_item = new char[strlen(menu)+1];
	strcpy(menu_item, menu);
	next = NULL;
}

void menu_node::set_next(menu_node *& toSet)
{
	this->next=toSet;
}

void menu_node::display()
{
	cout << menu_item << endl;
}


