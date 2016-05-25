// has-forever-while.cpp

int main(void)
{
	while(true); // this should bring up an offense
	// while(1); this shouldn't
	/*
	while(-1); this shouldn't either
	*/
	return 0;
}
