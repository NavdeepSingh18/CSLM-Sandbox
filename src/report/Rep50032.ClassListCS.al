report 50032 "Class List-CS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Class List-CS.rdlc';
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Course Master-CS"; "Course Master-CS")
        {
            column(Code_CourseCOLLEGE; Code)
            {
            }
            column(Description_CourseCOLLEGE; Description)
            {
            }
            column(Graduation_CourseCOLLEGE; Graduation)
            {
            }
            column(CompInfo_Name; CompInfo.Name)
            {
            }
            column(CompInfo_Address; CompInfo.Address)
            {
            }
            column(CompInfo_Address2; CompInfo."Address 2")
            {
            }
            column(Taxable_CourseCOLLEGE; Taxable)
            {
            }
            column(Tax1; Tax1)
            {
            }

            trigger OnAfterGetRecord()
            begin

                IF "Course Master-CS".Taxable THEN
                    Tax1 := 'Y'
                ELSE
                    Tax1 := 'N'
            end;

            trigger OnPreDataItem()
            begin
                CompInfo.GET();
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

    var
        CompInfo: Record "Company Information";
        Tax1: Text;
}

