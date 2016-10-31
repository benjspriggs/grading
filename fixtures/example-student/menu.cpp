#include "menu.h"
//#include "bst.h"
#include <iostream>
#include <fstream>
#include <cctype>
#include <cstring>
#include <cstdlib>


menu_item::menu_item()
{
	name = NULL;
	list = NULL;
	next = NULL;
}

menu_item::menu_item(char * in_name, ingredient_list *& in_list)
{
	name = new char [strlen(in_name)];
	strcpy(name, in_name);

	list = in_list;
	next = NULL;


}
void menu_item::set_next(menu_item * toAdd)
{
    next = toAdd;
}

/*
void meun_item::purchase(int amount)
{
	if(list->head)
		stock(amount, list->head);
	else
		return;
}

void menu_item::stock(int amount, ingredient_node * head)
{
	head->item.order(amount * head->units_needed);
	if(head->next)
		stock(amount, head->next);

	else
		return;
}
*/


entree::entree():menu_item()
{

}

entree::entree(char * in_name, ingredient_list *& in_list):menu_item(in_name, in_list)
{
}

void entree::purchase(int amount, bst *& ing_list)
{
	list->purchase(amount, ing_list);
}

void entree::order(bst *& ing_tree)
{

	list->order(ing_tree);

}

void entree::display()
{
	cout << name << endl;
	cout << "Ingredients: " << endl;
	list->display_all();
	cout << endl;
	if(next == NULL)
		return;
	next->display();
	
}



drink::drink(char * in_name, ingredient_list *& in_list):menu_item(in_name, in_list)
{

}

void drink::display()
{
	cout << name << endl;
	cout << "Ingredients: " << endl;
	list->display_all();
	cout << endl;
	if(next == NULL)
		return;
	next->display();

}

void drink::display(menu_item *& current)
{
	if(current == NULL)
	{
		cout << endl;
		return;
	}
	cout << name << endl;
	cout << "Ingredients: " << endl;
	list->display_all();
	cout << endl;
	display(current->get_next());

}

void drink::order(bst *& ing_tree)
{

	list->order(ing_tree);

}

void drink::purchase(int amount, bst *& ing_list)
{
	list->purchase(amount, ing_list);
}



appetizer::appetizer(char * in_name, ingredient_list *& in_list):menu_item(in_name, in_list)
{

}

void appetizer::display()
{
	cout << name << endl;
	cout << "Ingredients: " << endl;
	list->display_all();
	cout << endl;
	if(next == NULL)
		return;
	next->display();


}

void appetizer::display(menu_item *& current)
{
	if(current == NULL)
	{
		cout << endl;
		return;
	}
	cout << name << endl;
	cout << "Ingredients: " << endl;
	list->display_all();
	cout << endl;
	display(current->get_next());

}


void appetizer::order(bst *& ing_tree)
{

	list->order(ing_tree);

}

void appetizer::purchase(int amount, bst *& ing_list)
{
	list->purchase(amount, ing_list);
}




ingredient_list::ingredient_list()
{

}

void ingredient_list::add(char * name, char * meal, bst *& ing_tree)
{
	ingredient_node * temp;
	ingredient * current;
	current = ing_tree->retrieve(name);
	//ing_tree->add_menu(name, meal);
	if(!head)
		head = new ingredient_node(current);
	else
	{
		temp = new ingredient_node(current);
		 temp->set_next(head);
		 head = temp;
	}
}

void ingredient_list::order(bst *& ing_list)
{
	if(!head)
		return;
	head->order(ing_list);
	order(head->get_next(), ing_list);
}



void ingredient_list::order(ingredient_node *& current, bst *& ing_list)
{
	if(!current)
		return;
	current->order(ing_list);
	order(current->get_next(), ing_list);
}

void ingredient_list::display_all()
{
	if(!head)
	{
		cout << "No ingredients, it must be made of air" << endl;
		return;
	}
	head->display();

	display(head->get_next());


}

void ingredient_list::display(ingredient_node * current)
{
	if(!current)
		return;
	current->display();
	display(current->get_next());
}

void ingredient_list::purchase(int amount, bst *& ing_list)
{
	if(!head)
		return;
	head->purchase(amount, ing_list);
	purchase(amount, head->get_next(), ing_list);
}

void ingredient_list::purchase(int amount, ingredient_node * toPur, bst *& ing_list)
{
	if(!toPur)
		return;
	toPur->purchase(amount, ing_list);

}




ingredient_node::ingredient_node(ingredient *& itemToAdd)
{
	item = itemToAdd;
}



ingredient_node::ingredient_node()
{
 	next = NULL;

}
void ingredient_node::order(bst *& ing_list)
{
	node * toOrder = ing_list->retrieve(item->get_name());
	toOrder->order();
}


/*void ingredient_node::add(ingredient_node * current, bst *& ing_tree)
{
	current = new ingredient_node;
	current->item = ing_tree->retrieve(current->item.name);


}
*/
void ingredient_node::display()
{
	cout << item->get_name() << endl;
}

void ingredient_node::purchase(int amount, bst *& ing_list)
{
	node * toPur = ing_list->retrieve(item->get_name());
	toPur->purchase(amount);
}

void ingredient_node::set_next(ingredient_node *& toAdd)
{
    next = toAdd;
}


menu::menu()
{
	dinner_head = NULL;
	app_head = NULL;
	drink_head = NULL;
}

menu::menu(ifstream & infile, bst *& ing_tree)
{
	char * name, * meal, * ingredient;
	menu_item * item;
	char temp[50];
	//char drink[5] ={d,r,i,n,k}
	while(!infile.eof())
	{
		ingredient_list * list;
		list = new ingredient_list;

		infile.getline(temp, 50, ':');
		meal = new char[strlen(temp)+1];
		strcpy(meal, temp);

		infile.getline(temp, 50, ':');
		name = new char[strlen(temp)+1];
		strcpy(name, temp);

		infile.getline(temp, 50, ':');
		while(strcmp(temp, "end") != 0)
		{
			ingredient = new char[strlen(temp)+1];
			strcpy(ingredient, temp);
			list->add(ingredient, name, ing_tree);
			ing_tree->add_menu(name, ingredient);
			infile.getline(temp, 50, ':');

		}
		infile.ignore();

	if(strcmp(meal, "din") == 0)
        {
            item = new entree(name, list);
            add(item, dinner_head);
        }


        if(strcmp(meal, "app") == 0)
        {
            item = new appetizer(name, list);
            add(item, app_head);
        }


        if(strcmp(meal, "drink")== 0)
        {
            item = new drink(name, list);
            add(item, drink_head);
        }




		
		infile.peek();

	}



}

void menu::add(menu_item *& item, menu_item *& head)
{
    if(!head)
    {
        head = item;
    }
    else
    {
        menu_item * temp;
        temp = item;
        temp->set_next(head);
        head = temp;

    }
}

void menu::display_meals()
{
	dinner_head->display();
	app_head->display();
	drink_head->display();
}
