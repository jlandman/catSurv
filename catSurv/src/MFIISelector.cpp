#include "MFIISelector.h"

using namespace std;

SelectionType MFIISelector::getSelectionType() {
	return SelectionType::MFI;
}

Selection MFIISelector::selectItem() {
	Selection selection;
	selection.questions = questionSet.nonapplicable_rows;
	selection.values.reserve(questionSet.nonapplicable_rows.size());
	selection.name = "MFI";

	double max_mfii = 0.0;
	int max_item = -1;

	for (size_t i = 0; i < questionSet.nonapplicable_rows.size(); ++i) {
		int question = questionSet.nonapplicable_rows.at(i);
		selection.values.push_back(estimator.fii(question, prior));

		if (selection.values[i] > max_mfii) {
			max_item = question;
			max_mfii = selection.values[i];
		}
	}

	selection.item = max_item;
	selection.item = selection.item;
	return selection;

}

MFIISelector::MFIISelector(QuestionSet &questions, Estimator &estimation, Prior &priorModel) : Selector(questions,
                                                                                                      estimation,
                                                                                                      priorModel) { }