report 50059 "Bell Curve for GradeCS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Bell Curve for GradeCS.rdlc';
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Grade Cutoff Master-CS"; "Grade Cutoff Master-CS")
        {
            DataItemTableView = SORTING("No.", "Line No");
            RequestFilterFields = "No.", "Course Code", Semester, "Subject Type", "Subject Code", "Academic Year", Section, "Global Dimension 1 Code", "Global Dimension 2 Code", Year;
            column(CountStd; "Count Std")
            {
            }
            column(CountRevised; "Count Revised")
            {
            }
            column(CountStdPer; "Count Std Per")
            {
            }
            column(CountRevisedPer; "Count Revised Per")
            {
            }
            column(No; "No.")
            {
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
}

