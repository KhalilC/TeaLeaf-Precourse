# blackjack game


suits = ["s","d","h","c"]
cards = ["2","3","4","5","6","7","8","9","10","J","Q","K","A"]
deck = []
$points = {}
aces = ["Ad","Ac","As","Ah"]

#creates a deck of 52 cards
suits.each do |suit|
  cards.each do |card|
    deck << (card + suit)
  end
end

#creates a hash where each card is the key and the point value is the value, Aces are set to 11
def set_value(deck)
deck.each do |card|
  other_values = ["2","3","4","5","6","7","8","9"]
  face_values = ["J","Q", "K"]
  if card[0] == '1'
    $points[card] = 10
  elsif other_values.include?(card[0])
    $points[card] = card[0].to_i
  elsif card[0] == "A"
    $points[card] = 11
  else
    $points[card] = 10    
  end
end
end

#calculates the value of the hand
def calculate_total(hand)
  sum = 0
  hand.each do |card|
    value = $points[card]
    sum += value
  end
  sum
end

#checks to see if the initial two cards for player/dealer = 21
def initial_winner(hand_total, dealer_total, deck, mycards, dealercards)
  if hand_total == 21  && dealer_total == 21
    puts "21 for you and dealer.  It's a tie"
    play_again(deck)
  elsif hand_total == 21 && dealer_total != 21
    puts "You have 21.  You win!"
    play_again(deck)
  elsif dealer_total == 21 && hand_total != 21
    puts "Dealer has 21 and wins!"
    play_again(deck)
  else
    play(mycards, deck, dealercards, hand_total, dealer_total)
  end
end  

# creates the initial hand for the player and dealer
def initial_hand(deck)
  deck.shuffle!
  mycards = []
  dealercards = []
  mycards << deck.pop
  dealercards << deck.pop
  mycards << deck.pop
  dealercards << deck.pop
  return [mycards, dealercards]
end

# for printing the initial 2 cards
def print_hands(mycards, dealercards)
  mytotal = calculate_total(mycards)
  mytotal = ace_check(mycards, mytotal)
  dealertotal = calculate_total(dealercards)
  dealertotal = ace_check(dealercards, dealertotal)
  print "\nYour cards are: \n", mycards, "total: ", mytotal, "\n"
  print "Dealer's cards are: \n", dealercards, "total: ", dealertotal, "\n"
  return [mytotal, dealertotal]
  end

# for dealing cards to the dealer
def deal_dealer(hand, deck, dealertotal, playertotal)
  if dealertotal >= 17
    return dealertotal
  else
    while dealertotal < 17
      hand << deck.pop
      dealertotal = calculate_total(hand)
      dealertotal = ace_check(hand, dealertotal)
      print "\nDealers's cards are: \n", hand, "total: ", dealertotal, "\n"
    end
   end
   return dealertotal 
end

# for dealing cards to the player
def deal_player(hand, deck)
  hand << deck.pop
  new_total = calculate_total(hand)
  new_total = ace_check(hand, new_total)
  print "\nYour cards are: \n", hand, "total: ", new_total, "\n"
  return [new_total, hand]
end

#if total is over 21 check to see if the hand has an ace and removes 10 points(changes value to 1)
def ace_check(hand, total)
  if total > 21
    hand.each do |card|
      if card[0].include?("A")
        $points[card] = 1
        total = calculate_total(hand)
        return total      
      end     
    end
end
  else
    return total
end



# checks to see if the player has busted
def is_busted(card_total)
  if card_total > 21
    puts "Over 21.  BUSTED!"
  else
    return false
  end
end


def results(playertotal, dealertotal)
  if (dealertotal > playertotal) && dealertotal <= 21
    puts "Dealer has a final score of #{dealertotal}.  You have a final score of #{playertotal}.  Dealer wins!"
  elsif dealertotal == playertotal
    puts "Looks like a tie!  Dealer has a final score of #{dealertotal}.  You have a final score of #{playertotal}"
  elsif playertotal > dealertotal
    puts "You win!  Dealer has a final score of #{dealertotal}.  You have a final score of #{playertotal}"
  else
    puts "Dealer busted!  You win!  Your final score is #{playertotal}, and the dealer's final score is #{dealertotal}" 
  end
end


def play_again(deck)
  answers = ['y','n']
  answer = ''
  while not answers.include?(answer)
    puts "Would you like you play again?(y/n)"
    answer = gets.chomp.downcase
  end
  if answer == 'y'
    start(deck)
  else
    puts "Thanks for playing.  Goodbye!"
end
end

  
# next round after the initial 2 cards
def play(mycards, deck, dealercards, mytotal, dealertotal)
  choice = ''
  busted = false
  while choice != 's' && busted == false 
    puts "Would you like to 'hit' or 'stand'?(h/s)"
    choice = gets.chomp
    if choice == 'h'
      mytotal, mycards = deal_player(mycards, deck)
      busted = is_busted(mytotal)
    elsif choice == 's'
      print "Your final hand is ", mycards, "total: ", mytotal, "\n"
      dealertotal = deal_dealer(dealercards, deck, dealertotal, mytotal)
      results(mytotal, dealertotal)
    else
      puts "I don't understand!  Please enter 'h' or 's'."
    end
end
play_again(deck)
end

def start(deck)
set_value(deck)
mycards, dealercards = initial_hand(deck)
mytotal, dealertotal = print_hands(mycards, dealercards)
initial_winner(mytotal, dealertotal, deck, mycards, dealercards)
end

def intro()
puts "Welcome to Blackjack!\n"
puts "Please note that dealer stands at 17 and above"
puts "What is your name? "
name = gets.chomp
puts "#{name}, that's a cool name, let's start playing!"
puts "Press enter to start"
response = gets.chomp
end

start(deck)





