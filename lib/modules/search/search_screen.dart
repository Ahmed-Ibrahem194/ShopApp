import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/componant/componant.dart';
import 'cubit/cubit_search.dart';
import 'cubit/states_search.dart';

class SearchScreen extends StatelessWidget {

  var formKey = GlobalKey <FormState> ();
 var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(BuildContext context) => SearchCubit() ,
    child: BlocConsumer<SearchCubit,SearchStates>(
    listener: (context , state){},
    builder :(context , state)
      {
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children:
                [
                    defultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (String value)
                        {
                          if(value .isEmpty)
                            {
                              return 'Enter text ti search' ;
                            }
                        },
                      onSubmit : (String text)
                      {
                        SearchCubit.get(context).search(text);
                      },
                        labelText: 'Search',
                        prefix: Icons.search,
                    ),
                  SizedBox(
                    height: 10.0,
                  ),
                      if(state is SearchLoadingState)
                         LinearProgressIndicator(),
                  SizedBox(
                    height: 10.0,
                  ),

                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => buildListProduct(SearchCubit.get(context).model.data.data[index], context),
                      separatorBuilder:(context, index) => myDivider(),
                      itemCount:SearchCubit.get(context).model.data.data.length,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    ),
    );
  }
}
