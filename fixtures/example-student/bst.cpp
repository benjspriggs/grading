#include "bst.h"
//#include "ingredient.h"
#include <iostream>
#include <fstream>
#include <cctype>
#include <cstring>
#include <cstdlib>

bst::bst()
{
	root = NULL;
}

bst::bst(ifstream & infile)
{
	root = NULL;
   while(infile.eof() == false)
   {

		char * in_name,* g_alt,* d_alt,* p_alt;
	char b;
	int day, month, units;
	bool in_g = false;
	bool in_d = false;
	bool in_p = false;
//	node * inc_node;
	char temp[20];

	infile.getline(temp, 20, ':');
	in_name = new char[strlen(temp+1)];
	strcpy(in_name, temp);

	infile.getline(temp, 4, ':');
	units = atoi(temp);

	infile.getline(temp, 4, ':');
	day = atoi(temp);

	infile.getline(temp, 4, ':');
	month = atoi(temp);

	infile.get(b);
	infile.ignore();
	if(b == 'y')
	{
		in_g = true;
		
		infile.getline(temp, 20, ':');
		g_alt =  new char[strlen(temp+1)];
		strcpy(g_alt, temp);
	}
	else
	{
		g_alt = new char[strlen("None" +1)];
		strcpy(g_alt, "None");

	}
	

	infile.get(b);
	infile.ignore();
	if(b == 'y')
	{
		in_d = true;
		
		infile.getline(temp, 20, ':');
		d_alt =  new char[strlen(temp+1)];
		strcpy(d_alt, temp);
	}
	else
	{
		 d_alt = new char[strlen("None" +1)];
		strcpy(d_alt, "None");
	}

	infile.get(b);
	infile.ignore();

	if(b == 'y')
	{
		in_p = true;
		


		infile.getline(temp, 20, ':');
		p_alt =  new char[strlen(temp+1)];
		strcpy(p_alt, temp);
		infile.ignore();
	}
	else
	{
		p_alt = new char[strlen("None" +1)];
		strcpy(p_alt, "None");
	}

	 add(in_name, in_g, g_alt, in_d, d_alt, in_p, p_alt, units, day, month);

	infile.peek();
   }

}


void bst::add(node *& to_add)
{
	if(root == NULL)
		root = to_add;
	else
	{
		if(strcmp(root->get_name(), to_add->get_name()) < 0)
			add(root->get_right(), to_add);
		if(strcmp(root->get_name(), to_add->get_name()) >= 0)
			add(root->get_left(), to_add);

	}

}

void bst::add(node *& top, node *& to_add)
{
	if(top == NULL)
		top = to_add;
	else
	{
		if(strcmp(top->get_name(), to_add->get_name()) < 0)
			add(top->get_right(), to_add);
	if(strcmp(top->get_name(), to_add->get_name()) >= 0)
			add(top->get_left(), to_add);

	}

}

void bst::add(char *in_name, bool in_g, char * g_alt, bool in_d, char * d_alt, bool in_p, char* p_alt, int in_units, int in_day, int in_month)
{
	node * inc_node = new node(in_name, in_g, g_alt, in_d, d_alt, in_p, p_alt, in_units, in_day, in_month);

	add(inc_node);

}


void bst::add_menu(char * menu_name, char *ing_name )
{
	ingredient * current;
	current = retrieve(ing_name);
	
	current->add_menu(menu_name);
}

node *& bst::retrieve(char * name)
{
	if(!root)
		return root;
	int comp = strcmp(name, root->get_name());
	if(comp == 0)
		return root;
	if(comp < 0)
		return retrieve(name, root->get_left());
	if(comp > 0)
		return retrieve(name, root->get_right());
}

node *& bst::retrieve(char * name, node *& top)
{
	if(!top)
		return top;
	int comp = strcmp(name, top->get_name());
	if(comp == 0)
		return top;
	if(comp < 0)
		return retrieve(name, top->get_left());
	if(comp > 0)
		return retrieve(name, top->get_right());


}

void bst::display(node *& toDisp)
{
	if(toDisp == NULL)
		return;
	display(toDisp->get_left());
	toDisp->display();
	display(toDisp->get_right());

}

void bst::display_all()
{
	display(root->get_left());
	root->display();
	display(root->get_right());
}


LLL::LLL()
{
	head =  NULL;
}


list_node::list_node()
{
	next = NULL;
}

