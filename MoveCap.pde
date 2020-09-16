class MoveCap extends SplitCap {
  PVector[] imagesPos, basisPos;
  PVector holePos, nextHolePos, holeFillPos;
  int holeNum, nextHoleNum;
  int count;

  MoveCap(int x, int y) {
    super(x, y);
    count=0;
    holeNum = x*y-1;
    nextHoleNum = holeNum;
    imagesPos = new PVector[x*y];  //画像の実際のポジション
    basisPos = new PVector[x*y];  //画像の基準となるポジション
    for (int i=0; i<y; i++) {
      for (int j=0; j<x; j++) {
        imagesPos[i*x+j] = new PVector(width/x*j, height/y*i);
        basisPos[i*x+j] = new PVector(width/x*j, height/y*i);
      }
    }
    holePos = new PVector(imagesPos[holeNum].x, imagesPos[holeNum].y);  //空いているポジション
    nextHolePos = holePos;  //次の穴になるポジション
    holeFillPos = new PVector();  //穴だったポジション
  }

  void display() {
    for (int i=0; i<y; i++) {
      for (int j=0; j<x; j++) {
        image(spImages[i*x + j], imagesPos[i*x + j].x, imagesPos[i*x + j].y);
        text(str(i*x + j), imagesPos[i*x + j].x+30, imagesPos[i*x + j].y+30);
        line(imgWidth/x*j, 0, imgWidth/x*j, height);
      }
      line(0, imgHeight/y*i, width, imgHeight/y*i);
    }
  }

  void moveCap() {
    if (holePos.x == nextHolePos.x && holePos.y == nextHolePos.y) {
      holePos = imagesPos[holeNum];
      holeFillPos = holePos;
      nextHolePos = selectNextPos();
    } else {
      if (imagesPos[holeNum].x != nextHolePos.x) {
        if (imagesPos[holeNum].x > nextHolePos.x) imagesPos[holeNum].x -= 1;
        else imagesPos[holeNum].x += 1;
      }
      if (imagesPos[holeNum].y != nextHolePos.y) {
        if (imagesPos[holeNum].y > nextHolePos.y) imagesPos[holeNum].y -= 1;
        else imagesPos[holeNum].y += 1;
      }
    }
    
    if(holeFillPos.x != imagesPos[nextHoleNum].x){
      if(holeFillPos.x > imagesPos[nextHoleNum].x) imagesPos[nextHoleNum].x += 1;
      else imagesPos[nextHoleNum].x -= 1;
    }
    if(holeFillPos.y != imagesPos[nextHoleNum].y){
      if(holeFillPos.y > imagesPos[nextHoleNum].y) imagesPos[nextHoleNum].y += 1;
      else imagesPos[nextHoleNum].y -= 1;
    }
    
    
      //穴埋め
      //if(imagesPos[nextHoleNum].x != holeFillPos.x){
      //  if(imagesPos[nextHoleNum].x > holeFillPos.x) imagesPos[nextHoleNum].x -=1;
      //  else imagesPos[nextHoleNum].x +=1;
      //}
      //if(imagesPos[nextHoleNum].y != holeFillPos.y){
      //  if(imagesPos[nextHoleNum].y > holeFillPos.y) imagesPos[nextHoleNum].y -=1;
      //  else imagesPos[nextHoleNum].y +=1;
      //}
  }

  PVector selectNextPos() {
    PVector nextPos = new PVector();
    for (int i=0; i<imagesPos.length; i++) {
      if (holePos.x == basisPos[i].x && holePos.y == basisPos[i].y) {
        nextPos.set(basisPos[selectNeighborhood(fourNeighborhood(i))]);
        return nextPos;
      }
    }
    return nextPos;
  }


  ArrayList fourNeighborhood(int hNum) {
    ArrayList<Integer> nb = new ArrayList<Integer>();
    if (hNum%y == 0)
    {                        //左端のとき
      nb.add(hNum+1);  //右のマスを追加
      if (hNum+x < x*y) nb.add(hNum+x);  //上のマスを追加
      if (hNum-x > 0) nb.add(hNum-x);  //下のマスを追加  
      return nb;
    } else if ((hNum+1)%y == 0) {              //右端のとき
      nb.add(hNum-1);
      if (hNum+x < x*y) nb.add(hNum+x);
      if (hNum-x > 0) nb.add(hNum-x);
      return nb;
    } else if (hNum+x > x*y) {                 //下端のとき
      nb.add(hNum-x);
      if (hNum%y != 0) nb.add(hNum-1);
      if ((hNum+1)%y != 0) nb.add(hNum+1);
      return nb;
    } else if (hNum-x < 0) {                   //上端のとき
      nb.add(hNum+x);
      if (hNum%y != 0) nb.add(hNum-1);
      if ((hNum+1)%y != 0) nb.add(hNum+1);
      return nb;
    } else {                                      //端でないとき     
      nb.add(hNum-1);
      nb.add(hNum+1);
      nb.add(hNum+x);
      nb.add(hNum-x);
    }
    return nb;
  }

  int selectNeighborhood(ArrayList<Integer> nb) {
    print(nb);
    int rand = nb.get(int(random(nb.size())));
    println("-> "+rand);
    nextHoleNum = rand;
    return rand;
  }
}
