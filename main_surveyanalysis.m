% Combine all text entries into a single string
survey = readtable('Path to the survey in .xlsx format');

%Remove question entry
warning('off','all')
survey(:,1) = [];

%Get number of questions and participants
[question,person] = size(survey);

word_count = zeros(person,1);
for i = 1:person
    word_count(i) = wordcount(survey(:,i));

end

for i = [4,5,6,7,8,9,10,11,12,13,15,16,17,18,19,21]
    figure(i)
    wordfrequency(survey(i,:),i);
    figurename = ['WordFrequency_question',num2str(i),'.pdf'];
    saveas(gcf,figurename)
    close all

end

for i = 1:person
    figure(i)
    wordfrequency(survey(:,i),i);
    figurename = ['WordFrequency_participant',num2str(i),'.pdf'];
    saveas(gcf,figurename)
    close all
end
