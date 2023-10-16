report 50162 "Housing Cost"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Housing Cost Report.rdlc';

    dataset
    {
        dataitem("Room Category Fee Setup"; "Room Category Fee Setup")
        {
            RequestFilterFields = "Housing Group", "Housing ID";
            DataItemTableView = sorting("Housing ID");

            Column(LogoImageAUA; RecEduSetup."Logo Image")
            {

            }
            Column(LogoImageAICASA; RecEduSetup1."Logo Image")
            {

            }
            Column("Institute_Name"; RecEduSetup."Institute Name")
            {

            }
            Column("Institute_Address"; RecEduSetup."Institute Address")
            {

            }
            Column("Institute_Address2"; RecEduSetup."Institute Address 2")
            {

            }
            Column("Institute_City"; RecEduSetup."Institute City")
            {

            }

            Column("Institute_PostCode"; RecEduSetup."Institute Post Code")
            {

            }
            Column("Institute_Phone"; RecEduSetup."Institute Phone No.")
            {

            }
            Column("Institute_Email"; RecEduSetup.url)
            {

            }
            Column("Institute_FaxNo"; RecEduSetup."Institute Fax No.")
            {

            }
            column(Housing_Group; "Housing Group")
            {

            }
            column(Housing_ID; "Housing ID")
            {

            }
            column(Housing_Name; "Housing Name")
            {

            }
            column(Room_Category_Name; "Room Category Name")
            {

            }
            column(Cost; Cost1)
            {

            }
            column(With_Spouse_Cost; WithSpouseCost1)
            {

            }
            column(FilterShow; GETFILTERS())
            {

            }
            trigger OnAfterGetRecord()
            begin
                WithSpouseCost1 := 0;
                Cost1 := 0;
                RoomCategoryMaster.Reset();
                RoomCategoryMaster.SetRange("Room Category Code", "Room Category Code");
                RoomCategoryMaster.SetRange("Housing ID", "Housing ID");
                RoomCategoryMaster.SetFilter("Effective From", '<=%1', WorkDate());
                if RoomCategoryMaster.FindLast() then begin
                    WithSpouseCost1 := RoomCategoryMaster."With Spouse Cost";
                    Cost1 := RoomCategoryMaster.Cost;
                end;
            End;
        }
    }

    var
        RecEduSetup: Record "Education Setup-CS";
        RecEduSetup1: Record "Education Setup-CS";
        RoomCategoryMaster: Record "Room Category Fee Setup";
        WithSpouseCost1: Decimal;
        Cost1: Decimal;

    trigger OnPreReport()
    begin
        RecEduSetup.Reset();
        RecEduSetup.SetRange("Global Dimension 1 Code", '9000');
        IF RecEduSetup.FindFirst() then
            RecEduSetup.CALCFIELDS("Logo Image");

        RecEduSetup1.Reset();
        RecEduSetup1.SetRange("Global Dimension 1 Code", '9100');
        IF RecEduSetup1.FindFirst() then
            RecEduSetup1.CALCFIELDS("Logo Image");

    end;
}