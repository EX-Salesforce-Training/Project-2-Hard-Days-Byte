({
	generateQuote : function(component) {
        let quotes = ['47','47','47','42','I\'m sorry, Dave. I can\'t let you do that.','Allons-y!','Engage.','Make it so.',
                      'Klaatu barada nikto.'];
        let randN = Math.floor(Math.random() * quotes.length);
        let quote = quotes[randN];
        return quote;
	}
})