# Create a word count dict for spanish tweets
import csv, sys

filename = 'spanish_tweets'

try:
	tweets = open(filename + '.txt', 'r')
except:
	print 'Invalid log filename:', filename
	sys.exit(1)

word_count = {}

words = []
for line in tweets:
	for word in line.split(' '):
		words.append(word)



# Convert all the words to all lowercase letters
# words = [word.lower() for word in words]

words_new = []

#print words

# Go through each of the words - clean some up and skip some
# Add them to the words_new array

for word in words:
	if word == '':
		continue
	if word.startswith('#'):
		continue
	if word.startswith('@'):
		continue
	if word.startswith('"'):
		word = word[1:len(word)]
	if word.endswith('.'):
		word = word[0:len(word)-1]
	if word.startswith("'u"):
		word[2:len(word)]

	words_new.append(word)

words_new = [word.lower() for word in words_new]

for word in words_new:
	if word not in word_count:
		word_count[word] = 1
	else:
		word_count[word] += 1 

file = open('spanish_word_counts.csv', 'wb')
csv_out = csv.writer(file)
csv_out.writerow(['word', 'count'])
for word in sorted(word_count):
	csv_out.writerow([word, word_count[word]])
file.close()