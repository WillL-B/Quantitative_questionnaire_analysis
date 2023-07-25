function [totalwords] = wordcount(data)
% Extract the text data from the table
data = table2cell(data);
% Convert the table cells to a cell array of character vectors (strings)
data = cellfun(@char, data, 'UniformOutput', false);

% Filter out cells containing only numbers
data = data(cellfun(@(x) ~isnumeric(x), data));

% Concatenate all the text data into a single string
all_text = strjoin(data, ' ');

% Tokenize the text into individual words
words = split(all_text, {' ', '.', ',', '-', '(', ')', '{', '}', '[', ']', '!', '?'});

% Remove empty cells and convert all words to lowercase for case-insensitive counting
words = lower(words(~cellfun('isempty', words)));

% Count the frequency of each word using the 'unique' and 'histcounts' functions
[unique_words, ~, idx] = unique(words);
word_counts = histcounts(idx, numel(unique_words)+1);

[totalwords,~] = size(words);
disp(totalwords)

% Display the word count for each word and the corresponding word itself
% for i = 1:numel(unique_words)
%     fprintf('%s: %d\n', unique_words{i}, word_counts(i));
% end









end