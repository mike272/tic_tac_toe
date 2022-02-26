import 'dart:math';

var opponent = "O", player = "X", empty = "";
//board is 9 element array of form
//0 1 2
//3 4 5
//6 7 8
bool ArePossibleMovesLeft(var board) {
  for (var i = 0; i < 9; i++) {
    if (board[i] == empty) {
      return true;
    }
  }
  return false;
}

int findWinningCondition(var board) {
//  check rows for three identical symbols
  for (var row = 0; row < 9; row = row + 3) {
    if (board[row] == board[row + 1] && board[row] == board[row + 2]) {
      if (board[row] == player)
        return -100;
      else if (board[row] == opponent) return 100;
    }
  }
//  check columns for three identical symbols
  for (var col = 0; col < 3; col++) {
    if (board[col] == board[col + 3] && board[col] == board[col + 6]) {
      if (board[col] == player)
        return -100;
      else if (board[col] == opponent) return 100;
    }
  }
//check diagonals for three identical symbols
  if ((board[0] == board[4] && board[0] == board[8]) ||
      (board[2] == board[4] && board[2] == board[6])) {
    if (board[4] == player)
      return -100;
    else if (board[4] == opponent) return 100;
  }

  return 0;
}

int minimax(var board, int depth, bool isMax) {
  int score = findWinningCondition(board);
  //returning scores
  if (score == 100 || score == -100) return score;
  //returning tie if no more moves are left
  if (!ArePossibleMovesLeft(board)) {
    return 0;
  }
  //main minimax logic
  if (isMax) {
    int best = -1000;

    // Traverse all cells

    for (int j = 0; j < 9; j++) {
      // Check if cell is empty
      if (board[j] == empty) {
        // Make the move
        board[j] = opponent;

        // Call minimax recursively and choose
        // the maximum value
        best = max(best, minimax(board, depth + 1, !isMax) - depth);

        // Undo the move
        board[j] = empty;
      }
    }

    return best;
  }

  // If this minimizer's move
  else {
    int best = 1000;

    // Traverse all cells

    for (int j = 0; j < 9; j++) {
      // Check if cell is empty
      if (board[j] == empty) {
        // Make the move
        board[j] = player;

        // Call minimax recursively and choose
        // the minimum value
        best = min(best, minimax(board, depth + 1, !isMax) + depth);

        // Undo the move
        board[j] = empty;
      }
    }
    return best;
  }
}

// This will return the best possible move for the AI opponent
int findBestMove(var board) {
  int bestVal = -1000;
  int bestMove = -1;
  //board is 9 element array of form
  //0 1 2
  //3 4 5
  //6 7 8

  for (int j = 0; j < 9; j++) {
    if (board[j] == empty) {
      board[j] = opponent;
      int moveVal = minimax(board, 0, false);
      board[j] = empty;

      if (moveVal > bestVal) {
        bestMove = j;
        bestVal = moveVal;
      }
    }
  }

  return bestMove;
}
