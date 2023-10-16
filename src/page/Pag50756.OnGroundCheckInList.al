page 50756 "On-Ground Check-In List"
{
    Caption = 'Pending On-Ground Check-In List';

    Editable = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    CardPageID = "Student Detail Card-CS";
    SourceTable = "Student Master-CS";
    //SourceTableView = SORTING("No.") ORDER(Ascending) where("OLR Completed" = filter(true), Status = filter('ROL'));
    SourceTableView = SORTING("No.") ORDER(Ascending) where("OLR Completed" = filter(true), "Student Group" = filter(" "));
    RefreshOnActivate = true;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Admitted Year"; Rec."Admitted Year")
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("OLR Completed"; Rec."OLR Completed")
                {
                    ApplicationArea = All;
                }
                field("OLR Completed Date"; Rec."OLR Completed Date")
                {
                    ApplicationArea = All;
                }
                field("Student Group"; Rec."Student Group")
                {
                    ApplicationArea = All;
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Parent Student No."; Rec."Parent Student No.")
                {
                    ApplicationArea = All;
                }
                field("Financial Aid Approved"; Rec."Financial Aid Approved")
                {
                    ApplicationArea = All;
                }
                field("Payment Plan Applied"; Rec."Payment Plan Applied")
                {
                    ApplicationArea = All;
                }
                field("Payment Plan Instalment"; Rec."Payment Plan Instalment")
                {
                    ApplicationArea = All;
                }
                field("Self Payment Applied"; Rec."Self Payment Applied")
                {
                    ApplicationArea = All;
                }
                field("Customer Exists"; Rec."Customer Exists")
                {
                    ApplicationArea = All;
                }
                field("Housing Hold"; Rec."Housing Hold")
                {
                    ApplicationArea = All;
                }
                field("Bursar Hold"; Rec."Bursar Hold")
                {
                    ApplicationArea = All;
                }
                field("Financial Aid Hold"; Rec."Financial Aid Hold")
                {
                    ApplicationArea = All;
                }
                field("Registrar Hold"; Rec."Registrar Hold")
                {
                    ApplicationArea = All;
                }
                field("Immigration Hold"; Rec."Immigration Hold")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Name as on Certificate"; Rec."Name as on Certificate")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Roll No."; Rec."Roll No.")
                {
                    ApplicationArea = All;
                    Visible = False;
                }

                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Fathers Name"; Rec."Fathers Name")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Mothers Name"; Rec."Mothers Name")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("House No. Pref.1"; Rec."House No. Pref.1")
                {
                    Caption = 'House No. Pref.1';
                    ApplicationArea = all;
                    Visible = False;
                }
                field("House No. Pref.2"; Rec."House No. Pref.2")
                {
                    Caption = 'House No. Pref.2';
                    ApplicationArea = all;
                    Visible = False;
                }
                field("House No. Pref.3"; Rec."House No. Pref.3")
                {
                    Caption = 'House No. Pref.3';
                    ApplicationArea = all;
                    Visible = False;
                }
                field("Housing Group Pref.1"; Rec."Housing Group Pref.1")
                {
                    Caption = 'Housing Group Pref.1';
                    ApplicationArea = all;
                    Visible = False;
                }
                field("Housing Group Pref.2"; Rec."Housing Group Pref.2")
                {
                    Caption = 'Housing Group Pref.2';
                    ApplicationArea = all;
                    Visible = False;
                }
                field("Housing Group Pref.3"; Rec."Housing Group Pref.3")
                {
                    Caption = 'Housing Group Pref.3';
                    ApplicationArea = all;
                    Visible = False;
                }
                field("Room Category Pref.1"; Rec."Room Category Pref.1")
                {
                    Caption = 'Apartment Category Pref.1';
                    ApplicationArea = all;
                    Visible = False;
                }
                field("Room Category Pref.2"; Rec."Room Category Pref.2")
                {
                    Caption = 'Apartment Category Pref.2';
                    ApplicationArea = all;
                    Visible = False;
                }
                field("Room Category Pref.3"; Rec."Room Category Pref.3")
                {
                    Caption = 'Apartment Category Pref.3';
                    ApplicationArea = all;
                    Visible = False;
                }


                field("Housing Group"; Rec.HostelRoomBedAssigned(Rec."No.", 3))
                {
                    Caption = 'Housing Group';
                    ApplicationArea = all;
                    Visible = False;
                }
                field("Hostel ID"; Rec.HostelRoomBedAssigned(Rec."No.", 0))
                {
                    Caption = 'Housing ID';
                    ApplicationArea = all;
                    Visible = False;
                }
                field("Room Category Code"; Rec.HostelRoomBedAssigned(Rec."No.", 4))
                {
                    Caption = 'Apartment Category Code';
                    ApplicationArea = all;
                    Visible = False;
                }
                field("Room No."; Rec.HostelRoomBedAssigned(Rec."No.", 1))
                {
                    Caption = 'Apartment No.';
                    ApplicationArea = all;
                    Visible = False;
                }
                field("Bed No."; Rec.HostelRoomBedAssigned(Rec."No.", 2))
                {
                    Caption = 'Room No.';
                    ApplicationArea = all;
                    Visible = False;
                }
                field(Citizenship; Rec.Citizenship)
                {
                    ApplicationArea = All;
                    Visible = False;
                }

                field("Address To"; Rec."Address To")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Addressee; Rec.Addressee)
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Address1; Rec.Address1)
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Address2; Rec.Address2)
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("E-Mail Address"; Rec."E-Mail Address")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Mobile Number"; Rec."Mobile Number")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Address3; Rec.Address3)
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Caste; Rec.Caste)
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Quota; Rec.Quota)
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Date of Joining"; Rec."Date of Joining")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Date of Leaving"; Rec."Date of Leaving")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("New Student"; Rec."New Student")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Student Image"; Rec."Student Image")
                {
                    ApplicationArea = All;
                    Visible = False;
                }

                field("Fee Classification Code"; Rec."Fee Classification Code")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                    Visible = False;
                }


                field("Current Year"; Rec."Current Year")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Total Credits"; Rec."Total Credits")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Specialization; Rec.Specialization)
                {
                    ApplicationArea = All;
                    Visible = False;
                }

                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Prospectus No."; Rec."Prospectus No.")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Gap Taken"; Rec."Gap Taken")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Branch Transfer"; Rec."Branch Transfer")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Graduation; Rec.Graduation)
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Group; Rec.Group)
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Batch; Rec.Batch)
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Final Years Course"; Rec."Final Years Course")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Pay Type"; Rec."Pay Type")
                {
                    ApplicationArea = All;
                    Visible = False;
                }

                field("Section & Roll No."; Rec."Section & Roll No.")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Address4; Rec.Address4)
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Cor City"; Rec."Cor City")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Cor State"; Rec."Cor State")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Cor Country Code"; Rec."Cor Country Code")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Cor Post Code"; Rec."Cor Post Code")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Same As Permanent Address"; Rec."Same As Permanent Address")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Disability; Rec.Disability)
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Mother Tongue"; Rec."Mother Tongue")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Resident Status"; Rec."Resident Status")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("No. Of Assignment"; Rec."No. Of Assignment")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Cor District"; Rec."Cor District")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Parents Income"; Rec."Parents Income")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Scholarship Source"; Rec."Scholarship Source")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Internal Rank"; Rec."Internal Rank")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("External Rank"; Rec."External Rank")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Check Manually"; Rec."Check Manually")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Updated; Rec.Updated)
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Pre Qualification Subject"; Rec."Pre Qualification Subject")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Joining Day"; Rec."Joining Day")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Joining Month"; Rec."Joining Month")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Pre Qualification"; Rec."Pre Qualification")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("State Of Domicile"; Rec."State Of Domicile")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Semester I Credit Earned"; Rec."Semester I Credit Earned")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Semester II Credit Earned"; Rec."Semester II Credit Earned")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Semester III Credit Earned"; Rec."Semester III Credit Earned")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Semester IV Credit Earned"; Rec."Semester IV Credit Earned")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Semester V Credit Earned"; Rec."Semester V Credit Earned")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Semester VI Credit Earned"; Rec."Semester VI Credit Earned")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Semester VII Credit Earned"; Rec."Semester VII Credit Earned")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Semester VIII Credit Earned"; Rec."Semester VIII Credit Earned")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Net Semester CGPA"; Rec."Net Semester CGPA")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Net Year CGPA"; Rec."Net Year CGPA")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Year 1 Credit Earned"; Rec."Year 1 Credit Earned")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Year 2 Credit Earned"; Rec."Year 2 Credit Earned")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Year 3 Credit Earned"; Rec."Year 3 Credit Earned")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Year 4 Credit Earned"; Rec."Year 4 Credit Earned")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Year 1 GPA"; Rec."Year 1 GPA")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Year 2 GPA"; Rec."Year 2 GPA")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Year 3 GPA"; Rec."Year 3 GPA")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Year 4 GPA"; Rec."Year 4 GPA")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Pending For Registration"; Rec."Pending For Registration")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Course Completion NOC"; Rec."Course Completion NOC")
                {
                    ApplicationArea = All;
                    Visible = False;
                }

                field("Course Type"; Rec."Course Type")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Parent Login Password"; Rec."Parent Login Password")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Mobile Insert"; Rec."Mobile Insert")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Mobile Update"; Rec."Mobile Update")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Mobile Result"; Rec."Mobile Result")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Scholarship No"; Rec."Scholarship Source")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Applied For Scholarship"; Rec."Applied For Scholarship")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Approved For Scholarship"; Rec."Approved For Scholarship")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Blood Group"; Rec."Blood Group")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(NCL; Rec.Disability)
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(District; Rec.District)
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Alternate Email Address"; Rec."Alternate Email Address")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Emergency Contact No."; Rec."Emergency Contact No.")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Session; Rec.Session)
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Hold Result"; Rec."Hold Result")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Result; Rec.Result)
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Semester I Pass"; Rec."Semester I Pass")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Semester II Pass"; Rec."Semester II Pass")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Semester III Pass"; Rec."Semester III Pass")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Semester IV Pass"; Rec."Semester IV Pass")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Semester V Pass"; Rec."Semester V Pass")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Semester VI Pass"; Rec."Semester VI Pass")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Semester VII Pass"; Rec."Semester VII Pass")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Semester VIII Pass"; Rec."Semester VIII Pass")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Semester I GPA"; Rec."Semester I GPA")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Semester II GPA"; Rec."Semester II GPA")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Semester III GPA"; Rec."Semester III GPA")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Semester IV GPA"; Rec."Semester IV GPA")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Semester V GPA"; Rec."Semester V GPA")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Semester VI GPA"; Rec."Semester VI GPA")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Semester VII GPA"; Rec."Semester VII GPA")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Semester VIII GPA"; Rec."Semester VIII GPA")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Transport Facility"; Rec."Transport Facility")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Password; Rec.Password)
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Examination Form"; Rec."Examination Form")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Provisional Degree"; Rec."Provisional Degree")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Transf Admission Higher Sem"; Rec."Transf Admission Higher Sem")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Addmission to which Sem"; Rec."Addmission to which Sem")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Number of Credits Earned"; Rec."Number of Credits Earned")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Pass Port Issued Date"; Rec."Pass Port Issued Date")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Visa Issued Date"; Rec."Visa Issued Date")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("RC/RP Number"; Rec."RC/RP Number")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("RC/RP Issued Date"; Rec."RC/RP Issued Date")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("RC/RP Expiry Date"; Rec."RC/RP Expiry Date")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("S Form ID"; Rec."S Form ID")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Entrance Test Rank"; Rec."Entrance Test Rank")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Total Family Income"; Rec."Total Family Income")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Lateral Student"; Rec."Lateral Student")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Credit Student"; Rec."Credit Student")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Registrar Signoff"; Rec."Registrar Signoff")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Remark; Rec.Remark)
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Communication Address"; Rec."Communication Address")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

            action(StudentOnGroundCheckInProcess)
            {
                Caption = 'On Ground Check In Process';
                ApplicationArea = All;
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    StudentOnGroundCheckIn_lRec: Record "Student Master-CS";
                    CU50034: Codeunit WebServicesFunctionsCSL;

                Begin
                    If not Confirm('Do you want to confirm the process?', false) then
                        exit;

                    CurrPage.SetSelectionFilter(StudentOnGroundCheckIn_lRec);
                    IF StudentOnGroundCheckIn_lRec.FindSet() then begin
                        repeat
                            Studentongroundcheckin_New(StudentOnGroundCheckIn_lRec."No.");
                        //CU50034.StudentOnGroundCheckInBCtoPortal(StudentOnGroundCheckIn_lRec);//GMCSCOM
                        // StudentOnGroundCheckIn_lRec.Confirmed := true;
                        // StudentOnGroundCheckIn_lRec.Modify();
                        until StudentOnGroundCheckIn_lRec.Next() = 0;
                    end;
                    Message('Updated Successfully');
                    CurrPage.Update();

                end;

            }
            // action("Card")
            // {
            //     Caption = 'Card';
            //     Image = Card;
            //     Promoted = true;
            //     PromotedOnly = true;
            //     PromotedCategory = Process;
            //     RunObject = Page "Student Detail Card-CS";
            //     RunPageLink = "No." = FIELD("No.");

            // }
        }
    }
    //gourv 

    trigger OnOpenPage()
    var
        EducationSetup: Record "Education Setup-CS";
    begin
        // If Rec."Clear OLR Data" then begin
        //     Rec."OLR Completed" := false;
        //     Rec."OLR Completed Date" := 0D;
        //     Rec."Student Group" := Rec."Student Group"::" ";
        //     Rec."On Ground Check-In By" := '';
        //     Rec."On Ground Check-In On" := 0D;
        //     Rec."On Ground Check-In Complete By" := '';
        //     Rec."On Ground Check-In Complete On" := 0D;
        // end;

        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        IF EducationSetup.FindFirst() then;

        UserSetup.Get(UserId());
        Rec.FilterGroup(2);
        Rec.SetFilter("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        Rec.SetFilter(Status, '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6', 'DIS', 'WD', 'DEF', 'DEC', 'DCL', 'ADWD');
        Rec.FilterGroup(0);
        // SetFilter("Academic Year", '%1|%2', EducationSetup."Academic Year", EducationSetup."Returning OLR Academic Year");
        // SetFilter(Term, '%1|%2', EducationSetup."Even/Odd Semester", EducationSetup."Returning OLR Term");
    end;

    var
        StudentMasterCS: Record "Student Master-CS";
        StudentCount: Integer;
        UserSetup: Record "User Setup";
        Text005Lbl: Label 'Do you want to change student group for selected students?';
        Text006Lbl: Label 'Do you want to change student group for Student No. %1?';
        Text007Lbl: Label 'The selected Students, group has been changed.';
        Text008Lbl: Label 'Student group has been changed.';

    procedure Studentongroundcheckin_New(StudentNo: Code[20])
    var
        Stud: Record "Student Master-CS";
        HoldUpdate_lCU: Codeunit "Hold Bulk Upload";
    begin
        if StudentNo = '' then
            Error('Student No. cannot be empty while sending information about Student OnGround Check-In.');

        Stud.Reset();
        Stud.Get(StudentNo);
        if not Stud."OLR Completed" then
            //Error('OLR must be completed before On-Ground Check-In');
            Error('Due to some server issue, please try again later.');

        Stud."Student Group" := Stud."Student Group"::"On-Ground Check-In";
        Stud."On Ground Check-In On" := Today();
        Stud."On Ground Check-In By" := StudentNo;
        HoldUpdate_lCU.OnGroundCheckInStudentGroupEnable(StudentNo);
        Stud.Modify();
    end;
}