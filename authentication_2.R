twitter_tokens <- c(
  create_token(app = "spanish_mass_media_tokens", #whatever you named your app
               consumer_key = "Ztxt61kNQYYoL1hONLD5qRf78",
               consumer_secret = "ZxFWtZB0ODTfNbjJd8bdtSiraImVToQEnHtu0LNDNbHLYuH8VL"),
  create_token(app = "spanish_mass_media_roauth",
               consumer_key = "Ztxt61kNQYYoL1hONLD5qRf78",
               consumer_secret = "ZxFWtZB0ODTfNbjJd8bdtSiraImVToQEnHtu0LNDNbHLYuH8VL")
)
# (xxxxx's added but you get the point)

home_directory <- normalizePath("./")
file_name <- paste0(home_directory, "/", "twitter_tokens")
save(twitter_tokens, file = file_name)

cat("./twitter_tokens\n",
    file = paste0(home_directory, "/.Renviron"),
    append = TRUE)
