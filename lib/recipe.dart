import 'package:flutter/material.dart';

class LettuceRecipes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: Text('Lettuce Recipes'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RecipeCard(
              recipeName: 'Lettuce Salad',
              recipeImage: 'assets/Lettucesalad.png',
              recipeSteps: [
                'Wash and dry the lettuce leaves.',
                'Tear the lettuce leaves into bite-sized pieces.',
                'In a large bowl, mix the lettuce leaves with your desired toppings and dressing.',
                'Serve and enjoy!',
              ],
            ),
            RecipeCard(
              recipeName: 'Lettuce Wraps',
              recipeImage: 'assets/Lettucewrap.png',
              recipeSteps: [
                'Prepare your filling (ex: ground meat, vegetables, sauces)',
                'Wash and dry the lettuce leaves.',
                'Place a spoonful of the filling on each lettuce leaf.',
                'Wrap the leaf around the filling and secure with a toothpick.',
                'Serve and enjoy!',
              ],
            ),
            RecipeCard(
              recipeName: 'Lettuce Soup',
              recipeImage: 'assets/Lettucesoup.png',
              recipeSteps: [
                'In a large pot, sauté onions and garlic in olive oil until softened.',
                'Add chopped lettuce, chicken or vegetable broth, and seasonings to the pot.',
                'Bring to a boil, then reduce heat andlet simmer for 10-15 minutes.',
                      'Remove from heat and use an immersion blender to puree the soup.',
                      'Serve and enjoy!',
                      ],
                      ),
                      ],
                      ),
                      ),
                      );
                      }
                      }

                      class RecipeCard extends StatelessWidget {
                      final String recipeName;
                      final String recipeImage;
                      final List<String> recipeSteps;

                      RecipeCard({@required this.recipeName="", @required this.recipeImage="", @required this.recipeSteps=const[]});

                      @override
                      Widget build(BuildContext context) {
                      return Card(
                      margin: EdgeInsets.all(8),
                      child: Column(
                      children: [
                      Image.asset(recipeImage),
                      SizedBox(height: 8),
                      Text(
                      recipeName,
                      style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      ),
                      ),
                      SizedBox(height: 8),
                      Column(
                      children: recipeSteps.map((step) => Text(step)).toList(),
                      ),
                      ],
                      ),
                      );
                      }
                      }
