report 50207 "Completed MSPEA Application"
{
    Caption = 'Completed MSPEA Application';
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Completed MSPEA Application.rdl';

    dataset
    {
        dataitem(MSPE; MSPE)
        {
            column(Application_No; "Application No")
            {

            }
            column(Last_Name; "Last Name")
            {

            }
            column(First_Name; "First Name")
            {

            }
            column(Previous_Last_Name; "Previous Last Name")
            {

            }
            column(Previous_First_Name; "Previous First Name")
            {

            }
            column(Student_No; "Student No")
            {

            }
            column(Phone_Numbers; "Phone Numbers")
            {

            }
            column(Mobile_Cell; Mobile_Cell)
            {

            }
            column(Address; Address)
            {

            }
            column(City; City)
            {

            }
            column(State; State)
            {

            }
            column(Zip; Zip)
            {

            }
            column(Country; Country)
            {

            }
            column(ERAS; ERAS)
            {
                IncludeCaption = true;
            }
            column(CaRMS; CaRMS)
            {
                IncludeCaption = true;
            }
            column(Other_Specialty; "Other Specialty")
            {
                IncludeCaption = true;
            }
            column(Other_Specialty_Description; "Other Specialty Description")
            {

            }
            column(A_Exp; "1st Noteworthy Char. Exp.")
            {

            }
            column(A_StartDate; "1st Noteworthy Char. Dates")
            {

            }
            column(A_EndDate; "1st Noteworthy Char. End Date")
            {

            }
            column(A_Location; "1st Noteworthy Char. Location")
            {

            }
            column(B_Exp; "2nd Noteworthy Char. Exp.")
            {

            }
            column(B_StartDate; "2nd Noteworthy Char Dates")
            {

            }
            column(B_EndDate; "2nd Noteworthy Char. End Date")
            {

            }
            column(B_Location; "2nd Noteworthy Char Location")
            {

            }

            column(C_Exp; "3rd Noteworthy Char. Exp.")
            {

            }
            column(C_StartDate; "3rd Noteworthy Char Dates")
            {

            }
            column(C_EndDate; "3rd Noteworthy Char. End Date")
            {

            }
            column(C_Location; "3rd Noteworthy Char Location")
            {

            }
            column(D_Exp; "4th Noteworthy Char Exp.")
            {

            }
            column(D_StartDate; "4th Noteworthy Char Dates")
            {

            }
            column(D_EndDate; "4th Noteworthy Char. End Date")
            {

            }
            column(D_Location; "4th Noteworthy Char Location")
            {

            }
            column(E_Exp; "5th Noteworthy Char Exp.")
            {

            }
            column(E_StartDate; "5th Noteworthy Char Dates")
            {

            }
            column(E_EndDate; "5th Noteworthy Char. End Date")
            {

            }
            column(E_Location; "5th Noteworthy Char Location")
            {

            }
            column(Under_Graduate_School_Name; "Under Graduate School Name")
            {

            }
            column(Under_Graduate_Location; "Under Graduate Location")
            {

            }
            column(Under_Graduate_Month_Year; "Under Graduate Month Year")
            {

            }

            column(Under_Graduate_Degree; "Under Graduate Degree")
            {

            }

            column(Under_Graduate_Degree_Major; "Under Graduate Degree Major")
            {

            }

            column(Field_of_Study; "Field of Study")
            {

            }

            column(TermsandCondition; TermsandCondition)
            {

            }
        }
    }

    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 field(Name; SourceExpression)
    //                 {
    //                     ApplicationArea = All;

    //                 }
    //             }
    //         }
    //     }

    //     actions
    //     {
    //         area(processing)
    //         {
    //             action(ActionName)
    //             {
    //                 ApplicationArea = All;

    //             }
    //         }
    //     }
    // }

    var
        companyinfo: Record "Company Information";
        TermsandCondition: Boolean;

    trigger OnInitReport()
    begin
        TermsandCondition := true;
    end;
}