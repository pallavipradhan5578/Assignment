import 'package:assignment/providers/movie_provider.dart';
import 'package:assignment/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  void initState() {
    super.initState();
    // Fetch initial data
    Provider.of<MovieProvider>(context, listen: false).getUserApi();
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left:8.0),
          child: Text("Home",
          style: TextStyle(

            color: ColorConstant.primaryBlackColor,
            fontSize: 20
          ),
          ),
        ),centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              onChanged: (val) {
                if (val != '') {
                  movieProvider.getUserApi(query: val);
                } else {
                  movieProvider.getUserApi();
                }
              },
              decoration: InputDecoration(
                  labelText: "Search",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.search)),
            ),
            SizedBox(height: 20),
            Expanded(
              child: movieProvider.isRequesting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : movieProvider.movieList.isEmpty
                      ? Center(
                          child: Text("Not found"),
                        )
                      : ListView.builder(
                          itemCount: movieProvider.movieList.length,
                          itemBuilder: (context, index) {
                            final movie = movieProvider.movieList[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height / 4,
                                width: MediaQuery.of(context).size.width / 1,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Card(
                                        child: Padding(
                                          padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width/2.3),
                                          child: SizedBox(
                                            height: 100,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  movie["Title"]!,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w600,fontSize:20 ),overflow: TextOverflow.ellipsis,
                                                ),Text("ImdbID: ${movie["imdbID"]}",overflow: TextOverflow.ellipsis,style: TextStyle(
                                                      fontWeight: FontWeight.w400,fontSize:15 )),
                                               Text("Type: ${movie["Type"]}",overflow: TextOverflow.ellipsis,style: TextStyle(
                                                      fontWeight: FontWeight.w400,fontSize:15 ))
                                                ,Text("Year: ${movie["Year"]}",style: TextStyle(
                                                      fontWeight: FontWeight.w400,fontSize:15 ))
                                                

                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 15,
                                      bottom: 15,
                                      child: Padding(
                                        padding: const EdgeInsets.all(00.0),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              4.2,
                                          width: 150,
                                          decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(5),
  image: DecorationImage(
    image: NetworkImage(movie["Poster"]!),
    fit: BoxFit.fill,
    onError: (exception, stackTrace) => AssetImage('assets/placeholder.png'),
  ),
),

                                      ),
                                    ),
                                 ) ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
