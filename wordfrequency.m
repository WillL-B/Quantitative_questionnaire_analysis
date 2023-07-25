function [word_counts] = wordfrequency(data_table,j)
% Assuming you have the table 'data_table' containing the text data
% You can extract the text data from the table, concatenate it, and tokenize it into words

[question,~] = size(data_table);

% Check size of array if is across  participants or across questions
if question == 1
    % Extract the text data from the table
    data = [data_table.Person1, data_table.Person2, data_table.Person3, data_table.Person4, ...
        data_table.Person5, data_table.Person6, data_table.Person7, data_table.Person8, ...
        data_table.Person9];
    figtitle =['Word frequency question ',num2str(j)];
else
    data = data_table;
    data = table2cell(data);
    figtitle = ['Word frequency participant ',num2str(j)];

end

% Concatenate all the text data into a single string
all_text = strjoin(data, ' ');

% Tokenize the text into individual words
words = split(all_text, {' ', '.', ',', '-', '(', ')', '{', '}', '[', ']', '!', '?'});

% Remove empty cells and convert all words to lowercase for case-insensitive counting
words = lower(words(~cellfun('isempty', words)));

% Define the list of words to remove
wordsToRemove = {
    'aber', 'allein', 'also', 'andererseits', 'ansonsten', 'aufgrund', ...
    'aus diesem Grund', 'beispielsweise', 'besser gesagt', 'dagegen', ...
    'daher', 'damit', 'dann', 'darum', 'das heißt', 'dennoch', 'deswegen', ...
    'doch', 'einerseits', 'entweder', 'folglich', 'gleichzeitig', 'hingegen', ...
    'infolgedessen', 'jedoch', 'nämlich', 'nicht nur ... sondern auch', ...
    'obwohl', 'oder', 'sondern', 'sowie', 'trotzdem', 'überdies', ...
    'um ... zu', 'und', 'verglichen mit', 'vielmehr', 'weil', 'während', ...
    'zudem','des','dem','der','die','das','zu','wie','von','um','sind',...
    'sich','mit','ist','in','im','für','diese','ich','nicht','es','als',...
    'an','da','dass','ein','nach','bin','dies','eine','einer','etc','gab',...
    'I','zur','bei','auch','zum','am','den','2','3','e','wir','ab','sie',...
    '/','kann', 'sehr', 'nur', 'teil', 'viele', 'vielen', '\', 'meist', 'tage', ...
    'https:\\www', 'klären', '„', 'aufdurch', 'große', 'spielt', 'auf', 'beim', ...
    'neben', 'nur', 'sehr', 'was', 'möglich', 'kann', 'können', 'werden', 'auf', ...
    'gerade', 'verhält', 'nur', 'sehr', 'art', 'bescheid', 'selbst', 'wichtiger', ...
    'bitte', 'frage', 'bzw', 'habe', 'leider', 'richtige', 'aus', 'siehe', 'große', ...
    'man', 'ob', 'sehr', 'wenn', 'wird', 'eher', 'b', 'derzeit', 'wenn', 'vor', 'z', ...
    'sehr', 'durch', 'überspringen', 'bis', '0', '21', 'jahre', 'habe','»','5','4',...
    '1','2','3'
    };


% Filter out the words to remove from the word list
cleaned_words = {};
for i = 1:length(words)
    if ~ismember(words{i}, wordsToRemove)
        cleaned_words{end+1} = words{i};
    end
end

% Count the frequency of each word using the 'unique' and 'histcounts' functions
[unique_words, ~, idx] = unique(cleaned_words);
word_counts = histcounts(idx, numel(unique_words));

% Find the indices of words with count greater than 1
indices_greater_than_1 = find(word_counts > 1);

% Filter out words and counts that occur only once
word_counts = word_counts(indices_greater_than_1);
unique_words = unique_words(indices_greater_than_1);

% Sort the unique words and corresponding counts in descending order
[sorted_counts, sorted_indices] = sort(word_counts, 'descend');
sorted_words = unique_words(sorted_indices);

% Create a bar plot to visualize the word frequencies
bar(sorted_counts)
xticks(1:length(sorted_words))
xticklabels(sorted_words)
xtickangle(45)
xlabel('Words')
ylabel('Frequency')
title(figtitle,'FontSize',13)


end
