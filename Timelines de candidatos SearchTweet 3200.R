library("rtweet")
library('dplyr')

app  = "rtweet_stream_ematos"
ckey = ""
csec = ""
atok = ""
stok = ""

twitter_token = create_token(app,ckey,csec,atok,stok)

candidatos <- c("33374761", "74215006", "762402774260875265", "128372940", "2670726740", 
                "105155795", "870030409890910210","256730310", "73745956", "73889361",
                "989899804200325121")

#Informações estatisticas
infocand <- lookup_users(candidatos)

#Timelines
timelines<-get_timelines(candidatos, n=3200)
c <- as.matrix(timelines)
write.csv(c,'timelines.csv')

#Visualização

timelines %>%
  dplyr::filter(created_at > "2017-10-29") %>%
  dplyr::group_by(screen_name) %>%
  ts_plot("days", trim = 1L) +
  ggplot2::geom_point() +
  ggplot2::theme_minimal() +
  ggplot2::theme(
    legend.title = ggplot2::element_blank(),
    legend.position = "bottom",
    plot.title = ggplot2::element_text(face = "bold")) +
  ggplot2::labs(
    x = NULL, y = NULL,
    title = "Frequência de tweets publicados por candidatos às eleições 2018",
    subtitle = "Número de publicações por mês",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )
