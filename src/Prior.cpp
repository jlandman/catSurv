#include <gsl/gsl_randist.h>
#include <cmath>
#include "Prior.h"

using namespace std;

double Prior::dt(double x, int df, double mu) {
  // https://www.gnu.org/software/gsl/manual/html_node/The-t_002ddistribution.html
  return gsl_ran_tdist_pdf(x-mu,df);
}

double Prior::uniform(double x, double min, double max) {
  if(min <=x && x <= max)
  {
    return 1/(max-min);
  }
  return 0;
}

double Prior::normal(double x, double mean, double sd){
  static const double one_by_sqrt_2pi = 0.3989422804014327;
  x = (x - mean) / sd;
  return std::exp(-0.5*x*x)*one_by_sqrt_2pi / sd;
}

double Prior::prior(double x) {
  if (name == "STUDENT_T") {
    return dt(x, (int) parameters.at(1), parameters.at(0));
  }
  if (name == "UNIFORM") {
    return uniform(x, parameters.at(0), parameters.at(1));
  }
  if (name == "NORMAL"){
    return normal(x, parameters.at(0), parameters.at(1));
  }
  
  Rcpp::stop("%s is not a valid prior name.", name);
  throw std::invalid_argument("Invalid prior name"); 
}

Prior::Prior(Rcpp::S4 cat_df) : name(Rcpp::as<std::string>(cat_df.slot("priorName"))),
parameters(Rcpp::as<std::vector<double> >(cat_df.slot("priorParams"))) { }

Prior::Prior(const std::string &prior_name, const std::vector<double> &distribution_parameters) : 
  name(prior_name),
  parameters(distribution_parameters) { }