page 50763 "Current Semester Fee List"
{
    PageType = API;
    SourceTable = "Current Semester Fee";
    Caption = 'Current Semester Fee List';
    ApplicationArea = All;
    UsageCategory = Administration;
    EntityName = 'csF';
    EntitySetName = 'csF';
    DelayedInsert = true;
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    APIPublisher = 'csF01';
    APIGroup = 'csF';

    layout
    {
        area(content)
        {

            repeater(Group)
            {

                field(studentNo; Rec."Student No.")
                {

                    ApplicationArea = All;
                }
                field(studentName; Rec."Student Name")
                {

                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {

                    ApplicationArea = All;
                }
                field(AcademicYear; Rec."Academic Year")
                {

                    ApplicationArea = All;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field(FeeCode; Rec."Fee Code")
                {

                    ApplicationArea = All;
                }
                field(FixedAmount; Rec."Fixed Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}