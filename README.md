Sample code
======


This is a private repo containing some code samples and pieces of ideas that I got for my personal pet projects.


======

Banners:

	* Sony 
		After see the comps and listening to the client, I've decided to look for a non-cartoonish solution.

		In order to do that, I've mixed up timeline animation and code animation.

		The timeline animation was made by an animator and I did the perlin noise to create the feeling of "under-water".

		You can see the result here: http://projects.brunoribeiro.net/sony/300x250


		Note: A few months ago I've started using a base class that handles small things that we always need to do when working with banners, such as, create border, mask the banner, manage the steps.

		Inside the source/_libs/com/haus you can find a file called Banner.as, over there we have a small structure that helps us.


Web:


	* Paixão Nacional
		As you may (or may not) know, I love maps. In the last few years I've been working with maps in several projects for a wide range of clients, such as Tam Airlines, Ford, Allstate, etc.


		The First project that I wanna show is a pet project released in 2010. This project took me to several places, including - please don't laugh - to the Playboy magazine and MTV Brazil. You can see a little bit about the repercussion here: http://pnacional.tumblr.com/


		As I don't have a code sample to show, I'll at least show you a video showing how it used to work. http://videolog.tv/644830

		Currently I'm re-building it with node.js, well... at least the backend. I could show a little bit of the new backend, but as it's my first code with node, I don't think that's a good Idea.


	* Cornetto

		This game was one of the most complex projects I ever made.
		My role in this project was create a Flash Extension using JSFL to allow the game designers drag'n drop elements to the stage and export the level.

		When exported a xml file is generated and, inside the game, all the design is rendered in runtime.

		The Editor is ugly and the code isn't perfect, but giving the timing, amount of work, changes and all that thing that you prolly know, it's a pretty damn good tool.

		On the game end I did the assets manager, shell, i18n and rendered to the tiles.

		In this project I was not alone, Roberto did the physics, among other parts of the game.


	* Ford

		Last year I built two different tools for Ford, two maps that would be used to show how far you can go with a single tank of gas and another one that would allow you to plan your trip.


		The first one you can see here: https://ford-zce.appspot.com/static/contentwells/journey/index.html

		A sample of the source code you can see at Web/ford/journey

		The second one was aborted right after get done, but you can see it here: http://projects.brunoribeiro.net/ford/planner


	* SoundManager
		It's an unfinished, but used several times, lib to manage sounds on html websites. It was made in a couple hours, so... you may find some terrible ideas here :) Btw, if you do so, let me know, I really need to re-do this anyways.

		Note: Just the first link "Music 1" is set to auto-play.


	* Allstate Rider Risk
		The initial prototype is a simple map where you see options for a route and it will tell you the best route, avoinding dangerous points. It was made in a day and the code is a mess :)
		
		You can see it here: Allstate/gmaps_deploy/js/maps/Maps.js 

		The second part was build a real app once the project was awarded.
		You can see a little bit more here:

		Source: Allstate/final/project/static/js

		Note: The logic to rank the routes is now made on the backend to avoid performance issues.


	* Tilt
		This was used here: http://projects.brunoribeiro.net/sagres/
		It's a simple way to create the Tilt Shift effect. 

		Source: /Tilt/src

	
	* Spiral
		Back in 2008, using AS3 and PaperVision3d, I've created an spiral to show pictures. It was just a way to experiment the engine, work with optimization - techniques that somehow I still use - and check the differences between the types of light, shade, etc.

		Last year I decided to port it to Javascript, using 3d.js. The result you can see here: http://projects.brunoribeiro.net/3d_spiral/

	* If you were gisele
		My first pet project using maps. A simple app that would show you how much money would you make, walking from point A to point B, if you were Gisele Bündchen. 

		http://projects.brunoribeiro.net/ifyouwere
