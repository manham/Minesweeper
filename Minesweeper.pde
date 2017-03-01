

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private static final int NUM_ROWS = 20;
private static final int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined


void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[20][20];
    for(int row = 0; row < NUM_ROWS; row++){
        for(int col = 0; col < NUM_COLS; col++){
            buttons[row][col] = new MSButton(row, col);
        }
    }
    setBombs();
}
public void setBombs()
{
    int columns, rows;
    for(int i = 0; i < 20; i++){
        if(bombs.size() < 10){
            columns = (int)(Math.random()*20);
            rows = (int)(Math.random()*20);
            if(!bombs.contains(buttons[rows][columns])){
                bombs.add(buttons[rows][columns]);
            }
        }
        else{
            break;
        }
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    int markedBombs = 0;
    for(int i = 0; i < bombs.size(); i++){
        if(bombs.get(i).marked == true){
            markedBombs = markedBombs + 1;
        }
    }
    if(markedBombs == 10){
        return true;
    }
    return false;
}
public void displayLosingMessage()
{
    for(int i = 0; i < bombs.size(); i++){
        bombs.get(i).clicked = true;
    }
    buttons[9][6].setLabel("Y");
    buttons[9][7].setLabel("O");
    buttons[9][8].setLabel("U");
    buttons[9][10].setLabel("L");
    buttons[9][11].setLabel("O");
    buttons[9][12].setLabel("S");
    buttons[9][13].setLabel("E");
}
public void displayWinningMessage()
{
    buttons[9][6].setLabel("Y");
    buttons[9][7].setLabel("O");
    buttons[9][8].setLabel("U");
    buttons[9][10].setLabel("W");
    buttons[9][11].setLabel("I");
    buttons[9][12].setLabel("N");
    buttons[9][13].setLabel("!");
    
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed == true){
            marked = !marked;
            if(marked == false){
                clicked = false;
            }
        }
        else if(bombs.contains(this)){
            displayLosingMessage();
        }
        else if(countBombs(this.r, this.c) > 0){
            String numBombs = Integer.toString(countBombs(this.r, this.c));
            setLabel(numBombs);
        }
        else{
            if(isValid(r-1, c-1) == true && buttons[r-1][c-1].clicked == false){
                buttons[r-1][c-1].mousePressed();
            }
            if(isValid(r-1, c) == true && buttons[r-1][c].clicked == false){
                buttons[r-1][c].mousePressed();
            }
            if(isValid(r-1, c+1) == true && buttons[r-1][c+1].clicked == false){
                buttons[r-1][c+1].mousePressed();
            }
            if(isValid(r, c-1) == true && buttons[r][c-1].clicked == false){
                buttons[r][c-1].mousePressed();
            }
            if(isValid(r, c+1) == true && buttons[r][c+1].clicked == false){
                buttons[r][c+1].mousePressed();
            }
            if(isValid(r+1, c-1) == true && buttons[r+1][c-1].clicked == false){
                buttons[r+1][c-1].mousePressed();
            }
            if(isValid(r+1, c) == true && buttons[r+1][c].clicked == false){
                buttons[r+1][c].mousePressed();
            }
            if(isValid(r+1, c+1) == true && buttons[r+1][c+1].clicked == false){
                buttons[r+1][c+1].mousePressed();
            }
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS){
            return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(row-1, col-1) == true && bombs.contains(buttons[row-1][col-1])){
            numBombs = numBombs + 1;
        }
        if(isValid(row-1, col) == true && bombs.contains(buttons[row-1][col])){
            numBombs = numBombs + 1;
        }
        if(isValid(row-1, col+1) == true && bombs.contains(buttons[row-1][col+1])){
            numBombs = numBombs + 1;
        }
        if(isValid(row, col-1) == true && bombs.contains(buttons[row][col-1])){
            numBombs = numBombs + 1;
        }
        if(isValid(row, col+1) == true && bombs.contains(buttons[row][col+1])){
            numBombs = numBombs + 1;
        }
        if(isValid(row+1, col-1) && bombs.contains(buttons[row+1][col-1])){
            numBombs = numBombs + 1;
        }
        if(isValid(row+1, col) == true && bombs.contains(buttons[row+1][col])){
            numBombs = numBombs + 1;
        }
        if(isValid(row+1, col+1) == true && bombs.contains(buttons[row+1][col+1])){
            numBombs = numBombs + 1;
        }
        return numBombs;
    }
}



