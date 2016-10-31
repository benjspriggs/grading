//#ifndef MENU
//#define MENU
// MENU
//#include "ingredient.h"
#include "bst.h"
//class bst;

//class ingredient;


class ingredient_node
{
	public:
		ingredient_node();//
		ingredient_node(ingredient *& itemToAdd);//
		void display();//
		//void add(ingredient_node * current, bst *& ing_tree);
		ingredient * get_item() {return item;}
		void order(bst *& ing_list);//
		void purchase(int amount, bst *& ing_list);//
        void set_next(ingredient_node *& toAdd);
        ingredient_node *& get_next(){return next;}


	protected:

		ingredient * item;
        ingredient_node * next;


};

class ingredient_list
{
	public:
		ingredient_list();//
		void add(char * name, char * meal, bst *& ing_tree);//
		void order(bst *& ing_list);//
		void order(ingredient_node *& current, bst *& ing_list);//
		void display_all();//
		void display(ingredient_node * current);//
		void purchase(int amount, bst *& ing_list);//
		void purchase(int amount, ingredient_node * toPur, bst *& ing_list);//

	protected:

	ingredient_node * head;

};

class menu_item
{
	public:


		menu_item();//
		menu_item(char * name, ingredient_list *& list);//
		virtual void purchase(int amount, bst *& ing_list) = 0;
		virtual void display() = 0;
		void set_next(menu_item * toAdd);
		~menu_item();
		menu_item *& get_next(){return next;}




	protected:

		char * name;
		ingredient_list * list;
		menu_item * next;




};

class entree: public menu_item
{
	public:

		entree();//
		entree(char * in_name, ingredient_list *& in_list);//
		void purchase(int amount, bst *& ing_list);
	//	void substitute(ingredient &to_change)
		void order(bst *& ing_list);//
		void display();
		
	

//



	protected:
};

class drink: public menu_item
{
	public:
		drink(char * in_name, ingredient_list *& in_list);//
		virtual void purchase(int amount, bst *& ing_list);//
		void order(bst *& ing_list);//
		virtual void display();//
		void display(menu_item *& current);


	protected:

};

class appetizer: public menu_item
{

	public:
	    appetizer(char * in_name, ingredient_list *& in_list);
		virtual void purchase(int amount, bst *& ing_list);//
	//	void substitute(ingredient &to_change);
		void order(bst *& ing_list);//
		virtual void display();//
		void display(menu_item *& current);


	protected:

};






class menu
{
	public:
		menu();//
		menu(ifstream & infile, bst *& ing_tree);//
		void add(menu_item *& item, menu_item *& head);//
		void display_meals();

	protected:
		menu_item * dinner_head;
		menu_item * app_head;
		menu_item * drink_head;

};

//#endif
