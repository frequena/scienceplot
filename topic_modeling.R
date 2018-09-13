output$topic <- renderDataTable({
  
  docu <- as.DocumentTermMatrix(get(selected_dtm()))
  result <-  as.data.frame(terms(LDA(docu, 6), 4))
  return(result)
  
})
