var corpus = {
    canvas: document.getElementById("cuerpoJuego"),
    start : function() {
        this.canvas.width = 550;
        this.canvas.height= 400;
        this.context = this.canvas.getContext("2d");
        this.context.fillRect(0,0,this.canvas.width,this.canvas.height);
        InGame();
    },
    clear : function() {
        this.context.clearRect(0,0,this.canvas.width,this.canvas.height);
    }
}

function startGame() {
    corpus.start();
}