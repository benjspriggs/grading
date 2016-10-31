//#ifndef BST
//#define BST

#include "ingredient.h"
//class node;


#include <iostream>
#include <fstream>
using namespace std;

int this_is_a_global;
int this_is_a_global_initialized = 2;
const int this_is_a_global_constant = 4;

class bst
{

	public:

		bst();//
		bst(ifstream & infile);//
		void add(node *& to_add);//
		void add(node *& top, node *& to_add);//
		void add(char *in_name, bool in_g, char * g_alt, bool in_d, char * d_alt, bool in_p, char* p_alt, int in_units, int in_day, int in_month);//
		node *& retrieve(char * name);//
		node *& retrieve(char * name, node *& top);//
		//ingredient * swap(char * name, char * meal);
		void display(node *& toDisp);//
		void display_all();//
		//	int remove(&node);
		void add_menu(char * menu_name, char *ing_name );//



	protected:

		node * root;
};

class list_node
{

	public:
		list_node();//
		list_node *& get_next() {return next;}




	protected:

		list_node * next;

};

class LLL
{
	public:
		LLL();//
		virtual void add() = 0;

		~LLL();


	protected:
		list_node * head;

};

//#endif
