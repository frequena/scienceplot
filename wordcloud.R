

m = as.matrix(myDTM) #we define tdm as matrix

word_freqs = sort(rowSums(m), decreasing=TRUE) #now we get the word orders in decreasing order

dm = data.frame(word=names(word_freqs), freq=word_freqs) #we create our data set

palabra_nube <- wordcloud(dm$word, dm$freq, random.order=FALSE, colors=brewer.pal(6, "Dark2"), min.freq = 15)
