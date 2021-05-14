({
	generateQuote : function(component) {
        let quotes = ['QUOTE OF THE DAY','QUOTE OF THE DAY?','Doth I Quote Too Much?','WELL WELL WELL','4747474747'];
        let randN = Math.floor(Math.random() * quotes.length);
        let quote = quotes[randN];
        return quote;
	}
})