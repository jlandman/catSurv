#include "EPVSelector.h"

#include <iostream>
 
using namespace std;

Selection EPVSelector::nextItem() {
	// For every unanswered item, calculate the epv of that item
	Selection selection = Selection();
	selection.name = getSelectionName();
	selection.values.reserve(questionSet.nonapplicable_rows.size());
	selection.questions = questionSet.nonapplicable_rows;
	
	int min_item = -1;
	double min_epv = INFINITY;

	for (int row : questionSet.nonapplicable_rows) {
		double epv = estimator.expectedPV(row - 1, prior);
		selection.values.push_back(epv);

		if (epv < min_epv) {
			min_item =  row;
			min_epv = epv;
		}
	}
	selection.item = min_item;
	return selection;
}

SelectionType  EPVSelector::getSelectionType() {
	return SelectionType::EPV;
}

EPVSelector::EPVSelector(QuestionSet &questions, Estimator &estimation, Prior &priorModel) : Selector(questions, estimation,
                                                                                                      priorModel) { }

std::string EPVSelector::getSelectionName() {
	return "EPV";
}
