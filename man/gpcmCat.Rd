% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gpcmCat.R
\docType{methods}
\name{gpcmCat}
\alias{gpcmCat}
\alias{gpcm}
\alias{gpcmCat,data.frame-method}
\alias{gpcmCat,gpcm-method}
\title{Computerized Adaptive Testing Generalized Partial Credit Model}
\usage{
\S4method{gpcmCat}{data.frame}(data, quadraturePoints = 21, ...)

\S4method{gpcmCat}{gpcm}(data, quadraturePoints = NULL, ...)
}
\arguments{
\item{data}{A data frame of manifest variables or an object of class \code{gpcm}.}

\item{quadraturePoints}{A numeric to be passed into the \code{gpcm} function indicating the number of Gauss-Hermite quadrature points.  Only applicable when \code{data} is a data frame.  Default value is \code{21}.}

\item{...}{arguments to be passed to methods. For more details about the arguments, see \code{gpcm} in the \code{ltm} package.}
}
\value{
The function \code{gpcmCat} returns an object of class \code{Cat} with changes to the following slots:
\itemize{
\item \code{difficulty} A list of difficulty parameters, where each element in the list corresponds to the difficulty parameters for an item.
\item \code{discrimination} A vector consisting of of discrimination parameters for each item.
\item \code{model} The string \code{"gpcm"}, indicating this \code{Cat} object corresponds to a generalized partial credit model.
}

See \code{\link{Cat-class}} for default values of \code{Cat} object slots.  See \strong{Examples} and \code{\link{setters}} for example code to change slot values.
}
\description{
This function fits the generalized partial credit model for ordinal polytomous data and populates the fitted values for discrimination and difficulty parameters to an object of class \code{Cat}.
}
\details{
The \code{data} argument of the function \code{gpcmCat} is either a data frame or an object of class \code{gpcm} from the \code{ltm} package.  If it is a data frame each row represents a respondent and each column represents a question item.  If it is an object of the class \code{gpcm}, it is output from the \code{gpcm} function in the \code{ltm} package.

The \code{quadraturePoints} argument of the function \code{gpcmCat} is used only when the \code{data} argument is a data frame.  \code{quadraturePoints} is then passed to the \code{gpcm} function from the \code{ltm} package when fitting the generalized partial credit model to the data and is used when approximating the value of integrals.
}
\note{
In case the Hessian matrix at convergence is not positive definite try to use \code{start.val = "random"}.
}
\examples{
\dontrun{
## Creating Cat object with fitted object of class gpcm
data(polknowTAPS)
gpcm_fit <- gpcm(polknowTAPS, constraint = "gpcm", control = list(iter.qN = 200, GHk = 100))
class(gpcm_fit)
gpcm_cat <- gpcmCat(gpcm_fit)
}

## Creating Cat objects from large datasets is computationally expensive
## Load the Cat object created from the above code
data(gpcm_cat)

## Slots that have changed from default values
getModel(gpcm_cat)
getDifficulty(gpcm_cat)
getDiscrimination(gpcm_cat)

## Changing slots from default values
setEstimation(gpcm_cat) <- "MLE"
setSelection(gpcm_cat) <- "MFI"



}
\references{
Baker, Frank B. and Seock-Ho Kim. 2004. Item Response Theory: Parameter Estimation Techniques. New York: Marcel Dekker.

Muraki, Eiji. 1992. ``A generalized partial credit model: Application of an EM algorithm." ETS Research Report Series 1992(1):1-30.

Rizopoulos, Dimitris. 2006. ``ltm: An R Package for Latent Variable Modeling and Item Response Theory Analyses." Journal of Statistical Software 17(5):1-25.
}
\seealso{
\code{\link{Cat-class}}, \code{\link{grmCat}}, \code{\link{polknowTAPS}}, \code{\link{probability}}
}
\author{
Haley Acevedo, Ryden Butler, Josh W. Cutler, Matt Malis, Jacob M. Montgomery, Tom Wilkinson, Erin Rossiter, Min Hee Seo, Alex Weil
}
