youtube_list <- function(video_df, playlist_id) {
  intro_p <- glue::glue("Videos for each section of the lecture are [available at this YouTube playlist](https://www.youtube.com/playlist?list={playlist_id}).")
  
  videos_in_list <- dplyr::mutate(
    video_df,
    li = purrr::map2_chr(
      title, youtube_id, ~{
        glue::glue("- [{.x}](https://www.youtube.com/watch?v={.y}&list={playlist_id})")
      })
  )
  
  video_embed <- glue::glue('<div class="embed-responsive embed-responsive-16by9">
<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/videoseries?list={playlist_id}" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>')
  
  final <- paste(intro_p,
                 paste(videos_in_list$li, collapse = "\n"),
                 "You can also watch the playlist (and skip around to different sections) here:",
                 video_embed,
                 sep = "\n\n")
  
  cat(final)
}
