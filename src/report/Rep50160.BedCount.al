report 50160 "Bed Count"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Bed Count Report.rdl';

    dataset
    {
        dataitem("Housing Master"; "Housing Master")
        {
            RequestFilterFields = "Housing Group", "Housing ID";
            DataItemTableView = sorting("Housing ID");
            column(Filter_Caption; GETFILTERS())
            {

            }
            Column(LogoImageAUA; RecEduSetup."Logo Image")
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
            Column(LogoImageAICASA; RecEduSetup1."Logo Image")
            {

            }
            column(Housing_ID; "Housing ID")
            {

            }
            column(Housing_Name; "Housing Name")
            {

            }
            column(Housing_Group; "Housing Group")
            {

            }
            column(LeaseEndDate; LeaseEndDate)
            {

            }
            dataitem("Room Category Master"; "Room Category Master")
            {
                DataItemTableView = sorting("Room Category Code");
                column(Room_Category_Code; "Room Category Name")
                {

                }
                column(TotalCount; TotalCount)
                {

                }

                column(AssignedBeds; AssignedBeds)
                {

                }

                column(AvaiableBeds; AvaiableBeds)
                {

                }
                trigger OnAfterGetRecord()
                begin
                    TotalCount := 0;
                    AvaiableBeds := 0;
                    AssignedBeds := 0;
                    RoomMaster.Reset();
                    RoomMaster.SetRange("Room Category Code", "Room Category Code");
                    RoomMaster.SetRange("Housing ID", "Housing Master"."Housing ID");
                    If RoomMaster.FindSet() then
                        repeat
                            RoomWiseBed.Reset();
                            RoomWiseBed.SetRange("Room No.", RoomMaster."Room No.");
                            RoomWiseBed.SetRange("Housing ID", "Housing Master"."Housing ID");
                            RoomWiseBed.SetRange(Blocked, false);
                            If RoomWiseBed.FindSet() then
                                repeat
                                    TotalCount := TotalCount + 1;
                                    If RoomWiseBed.Available = false then
                                        AssignedBeds := AssignedBeds + 1
                                    Else
                                        AvaiableBeds := AvaiableBeds + 1;
                                until RoomWiseBed.Next() = 0;
                        until RoomMaster.Next() = 0;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                ContractDetail("Housing ID", LeaseStartDate, LeaseEndDate, ContractNo);
            end;
        }
    }

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

    var
        RecEduSetup: Record "Education Setup-CS";
        RecEduSetup1: Record "Education Setup-CS";
        RoomMaster: record "Room Master";
        RoomWiseBed: Record "Room Wise Bed";
        TotalCount: Integer;
        AvaiableBeds: Integer;
        AssignedBeds: Integer;
        LeaseStartDate: Date;
        LeaseEndDate: Date;
        ContractNo: Code[20];



}