import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_application/api/model/movies/movies.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/core/utils/app_images.dart';
import 'package:movie_application/core/utils/size_utils.dart';
import 'package:movie_application/core/widget/custom_image_asset.dart';
import 'package:movie_application/features/common/utils/main_error_widget.dart';
import 'package:movie_application/features/common/utils/main_loading_widget.dart';
import 'package:movie_application/features/common/widget/app_text_field.dart';
import 'package:movie_application/features/ui/home/tabs/search_tab/cubit/search_cubit.dart';
import 'package:movie_application/features/ui/home/tabs/search_tab/cubit/search_state.dart';
import 'package:movie_application/features/ui/movie_details/movie_details_screen.dart';

import '../../../../common/widget/movie_poster_card.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(),
      child: const _SearchContent(),
    );
  }
}

class _SearchContent extends StatefulWidget {
  const _SearchContent();

  @override
  State<_SearchContent> createState() => _SearchContentState();
}

class _SearchContentState extends State<_SearchContent> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(
          () => context.read<SearchCubit>().onQueryChanged(_controller.text),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        title: AppTextField(
          prefixIcon: CustomImageAsset(path: AppImages.searchIconImagePath),
          controller: _controller,
          hint: 'Search',
        ),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return switch (state) {
            SearchInitial() => _buildPlaceholder(),
            SearchLoading() => const MainLoadingWidget(),
            SearchError(:final message) => Center(
              child: SingleChildScrollView(
                child: MainErrorWidget(
                  errorMessage: message,
                  onPressed: () => context.read<SearchCubit>().search(),
                ),
              ),
            ),
            SearchSuccess(:final movies) =>
            movies.isEmpty ? _buildPlaceholder() : _buildResults(movies),
          };
        },
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Center(child: CustomImageAsset(path: AppImages.searchImagePath));
  }

  Widget _buildResults(List<Movies> movies) {
    final double spacing = SizeUtils.getWidth(context, 16);

    return GridView.builder(
      padding: EdgeInsets.all(spacing),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: movies.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: 2 / 3,
      ),
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MoviePosterCard(
          imageUrl: movie.mediumCoverImage ?? '',
          rating: movie.rating ?? 0.0,
          width: 120,
          onTap: () {
            final id = movie.id;
            if (id == null) return;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MovieDetailsScreen(movieId: id),
              ),
            );
          },
        );
      },
    );
  }
}