report 50056 "Subject Credit CutOff List"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Subject Credit CutOff List.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Grade Cutoff Master-CS"; "Grade Cutoff Master-CS")
        {
            DataItemTableView = SORTING("Subject Code", "Max Percentage")
                                ORDER(Descending);
            RequestFilterFields = "Program", "Course Code", Semester, "Subject Code";
            column(CourseCode_GradeAllocationMaster; "Grade Cutoff Master-CS"."Course Code")
            {
            }
            column(Semester_GradeAllocationMaster; "Grade Cutoff Master-CS".Semester)
            {
            }
            column(AcademicYear_GradeAllocationMaster; "Grade Cutoff Master-CS"."Academic Year")
            {
            }
            column(SubjectCode_GradeAllocationMaster; "Grade Cutoff Master-CS"."Subject Code")
            {
            }
            column(SubjectType_GradeAllocationMaster; "Grade Cutoff Master-CS"."Subject Type")
            {
            }
            column(Grade_GradeAllocationMaster; "Grade Cutoff Master-CS".Grade)
            {
            }
            column(MinPercentage_GradeAllocationMaster; "Grade Cutoff Master-CS"."Min Percentage")
            {
            }
            column(MaxPercentage_GradeAllocationMaster; "Grade Cutoff Master-CS"."Max Percentage")
            {
            }
            column(NoofCandiatesCore_GradeAllocationMaster; "Grade Cutoff Master-CS"."No of Candiates (Core)")
            {
            }
            column(NoofCandiatesElective_GradeAllocationMaster; "Grade Cutoff Master-CS"."No of Candiates ( Elective)")
            {
            }
            column(Program_GradeAllocationMaster; "Grade Cutoff Master-CS"."Program")
            {
            }
            column(GETFILTERS; "Grade Cutoff Master-CS".GETFILTERS())
            {
            }
            column(NoCandiates; NoCandiates)
            {
            }
            column(TotalCore_GradeAllocationMaster; "Grade Cutoff Master-CS"."Total Core")
            {
            }
            column(TotalElective_GradeAllocationMaster; "Grade Cutoff Master-CS"."Total Elective")
            {
            }
            column(Percentage_GradeAllocationMaster; "Grade Cutoff Master-CS".Percentage)
            {
            }
            column(Desc; Desc)
            {
            }
            column(Image; DimensionValue.Image)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SubjectMasterCS.Reset();
                SubjectMasterCS.SETRANGE(Code, "Subject Code");
                IF SubjectMasterCS.findfirst() THEN
                    Desc := SubjectMasterCS.Description;


                IF ("Grade Cutoff Master-CS"."Subject Code" = 'PE-I') OR ("Grade Cutoff Master-CS"."Subject Code" = 'PE-II') OR
                ("Grade Cutoff Master-CS"."Subject Code" = 'PE-III') OR ("Grade Cutoff Master-CS"."Subject Code" = 'PE-IV') OR
                ("Grade Cutoff Master-CS"."Subject Code" = 'PE-V') OR ("Grade Cutoff Master-CS"."Subject Code" = 'PE-VI') THEN
                    CurrReport.Skip();
            end;
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

    trigger OnPreReport()
    begin
        DimensionValue.Reset();
        DimensionValue.SETRANGE(DimensionValue.Code, '09');
        DimensionValue.findfirst();
        DimensionValue.CALCFIELDS(DimensionValue.Image);
    end;

    var
        SubjectMasterCS: Record "Subject Master-CS";
        DimensionValue: Record "Dimension Value";
        NoCandiates: Integer;
        Desc: Text[100];

}

