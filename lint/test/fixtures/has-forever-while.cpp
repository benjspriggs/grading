// has-forever-while.cpp

int main(void)
{
	while(true); // this should bring up an offense
	// while(1); this shouldn't
	return 0;
}
