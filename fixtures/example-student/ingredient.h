//#ifndef ING
//#define ING

//#include "menu.h"
//#include "bst.h"
//class menu
//class list_node;





class menu_node
{
	public:
		menu_node(char * menu);//
		void display();
		void set_next(menu_node *& toSet);
		menu_node * get_next(){return next;}



	protected:

		char * menu_item;
		menu_node * next;
};


class menu_list
 {
	public:

		menu_list();//
		menu_list(char * menu);
		void add_node(char * menu);//
		void display_all();//
		void display(menu_node * top);//

	protected:

		menu_node * head;
};

class ingredient
{
	public:
		ingredient();//
		ingredient(char *in_name, bool in_g, char * g_alt, bool in_d, char * d_alt, bool in_p, char* p_alt, int in_units, int in_day, int in_month);//

		void add_menu(char * menu_name);//

		void stock(int amount);//
		void order();//
		char * get_name(){return name;}
		void display();
		~ingredient();



	protected:
		char * name, * gluten_alt, * dairy_alt, * peanuts_alt;
		bool gluten;
		bool dairy;
		bool peanuts;
	//	int key;
		int day, month;
		int units;
		menu_list * list;


};


class node:public ingredient
{
	public:

		node();//
	//	node(& ingredient);//
		node(char * in_name, bool in_g, char * g_alt, bool in_d, char * d_alt, bool in_p, char * p_alt, int in_units, int in_day, int in_month);//
		node *& get_right(){return right;}
		node *& get_left(){return left;}
		void purchase(int amount);
		~node();


	protected:

		node * left;
		node * right;



};


//#endif
