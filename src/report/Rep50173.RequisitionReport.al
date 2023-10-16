report 50173 "Requisition Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Requisition Report.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Requisition Header"; "Requisition Header")
        {
            DataItemTableView = SORTING("Document Type", "No.");
            RequestFilterFields = "No.";
            column(Picture; CompInfo.Picture)
            {
            }
            column(Approval_StatusH; "Approval Status")
            {
            }
            column(Company_name; CompInfo.Name)
            {
            }
            column(Comp_Add; CompInfo.Address + ' ,')
            {
            }
            column(Comp_Add3; CompInfo."Address 2" + ', ' + CompInfo.City + '-' + CompInfo."Post Code")
            {
            }
            column(Comp_TIN; 'TIN No.')
            {
            }
            column(Loc_Name; Loc_Name)
            {
            }
            column(Loc_Add1; "Requisition Header"."Location Code")
            {
            }
            column(Loc_Add2; Loc_Add2)
            {
            }
            column(Loc_PostCode; Loc_PostCode)
            {
            }
            column(Loc_Phone; Loc_Phone)
            {
            }
            column(Loc_City; Loc_City)
            {
            }
            column(Loc_GST; Loc_GST)
            {
            }
            column(Loc_TAN; 'CIN No.')
            {
            }
            column(DocumentNo; "Requisition Header"."No.")
            {
            }
            column(PostingDate; FORMAT("Requisition Header"."Posting Date"))
            {
            }
            column(LocationCode; "Requisition Header"."Location Code")
            {
            }
            column(BranchCode; "Requisition Header"."Global Dimension 1 Code")
            {
            }
            column(DepartmentCode; "Requisition Header"."Department Name")
            {
            }


            column(Indent_No; "Requisition Header"."No.")
            {
            }
            column(Indent_Create_By; "Requisition Header"."User Id")
            {
            }
            column(Indent_Appoved_By; "Requisition Header"."Approved By")
            {
            }
            column(Ist_Level_Approvel; User_Id[2])
            {
            }
            column(sec_Level_Approvel; User_Id[3])
            {
            }
            column(third_Level_Approvel; User_Id[4])
            {
            }
            column(User_Id1; User_Id[1])
            {
            }
            column(UserName1; User_Name[1])
            {
            }
            column(UserName2; User_Name[2])
            {
            }
            column(UserName3; User_Name[3])
            {
            }
            column(UserName4; User_Name[4])
            {
            }

            column(User_Date1; User_Date[1])
            {
            }
            column(User_Date2; User_Date[2])
            {
            }
            column(User_Date3; User_Date[3])
            {
            }
            column(User_Date4; User_Date[4])
            {
            }
            column(Name; Name)
            {
            }
            column(Address; Address)
            {
            }
            column(Address2; Address2)
            {
            }
            column(City; City)
            {
            }
            column(PostCode; PostCode)
            {
            }
            column(Country; Country)
            {
            }
            dataitem("Requestion Line"; "Requisition Line_")
            {
                CalcFields = "Stock In Hand";
                DataItemLink = "Document No." = FIELD("No."),
                               "Document Type" = FIELD("Document Type");
                column(No_RequisitionLine; "Requestion Line"."Item Code")
                {
                }
                column(Status; Status)
                {
                }
                column(Description; "Requestion Line".Description + ' ' + "Requestion Line"."Description 2")
                {
                }

                column(Quantity; "Requestion Line"."Requested Quantity")
                {
                }
                column(Type_RequisitionLine; "Requestion Line".Type)
                {
                }

                column(BinCode_RequisitionLine; "Requestion Line"."Bin Code")
                {
                }
                column(LocationCode_RequisitionLine; "Requestion Line"."Location Code")
                {
                }
                column(Stoke_IN_HAnd; "Requestion Line"."Stock In Hand")
                {
                }
                column(Remark; "Requestion Line".Remarks)
                {
                }

                column(SRNo; SRNo)
                {
                }
                column(UOM; "Requestion Line"."Unit of Measure Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SRNo += 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                RecLocation.RESET();
                RecLocation.SETRANGE(RecLocation.Code, "Location Code");
                IF RecLocation.FINDFIRST() THEN BEGIN
                    Loc_Name := RecLocation.Name;
                    Loc_Add1 := RecLocation.Address;
                    Loc_Add2 := RecLocation."Address 2";
                    Loc_PostCode := RecLocation."Post Code";
                    Loc_Phone := RecLocation."Phone No.";
                    Loc_City := RecLocation.City;
                    Loc_GST := '';
                    Loc_TAN := '';
                END;
                SRNo := 0;
                CLEAR(RecUserSetup);
                CLEAR(User_Id);
                CLEAR(User_Name);
                CLEAR(K);
                CLEAR(User_Date);
                IF "Requisition Header"."User Id" <> '' THEN BEGIN
                    K += 1;
                    RecUserSetup[1].GET("Requisition Header"."User Id");
                    User_Id[1] := RecUserSetup[1]."User Id";
                    User_Name[1] := 'Created by';
                    User_Date[1] := DT2DATE("Requisition Header"."Date & Time");
                END ELSE BEGIN
                    User_Name[1] := '';
                    User_Id[1] := '';
                    User_Date[1] := 0D;
                END;
                IF "Requisition Header"."1st Level Approver ID" <> '' THEN BEGIN
                    K += 1;
                    RecUserSetup[2].GET("Requisition Header"."1st Level Approver ID");
                    User_Id[2] := RecUserSetup[2]."User ID";
                    User_Name[2] := '1st Approval';
                    User_Date[2] := "Requisition Header"."1st Level Approved Date";
                END ELSE BEGIN
                    User_Name[2] := '';
                    User_Id[2] := '';
                    User_Date[2] := 0D;
                END;

                IF "Requisition Header"."2nd Level Approver ID" <> '' THEN BEGIN
                    K += 1;
                    RecUserSetup[3].GET("Requisition Header"."2nd Level Approver ID");
                    User_Id[3] := RecUserSetup[3]."User Id";
                    User_Name[3] := '2nd Approval';
                    User_Date[3] := "Requisition Header"."2nd Level Approved Date";
                END ELSE BEGIN
                    User_Name[3] := '';
                    User_Id[3] := '';
                    User_Date[3] := 0D;
                END;

                IF "Requisition Header"."3rd Level Approver ID" <> '' THEN BEGIN
                    K += 1;
                    RecUserSetup[4].GET("Requisition Header"."3rd Level Approver ID");
                    User_Id[4] := RecUserSetup[4]."User Id";
                    User_Name[4] := '3rd Approval';
                    User_Date[4] := "Requisition Header"."3rd Level Approved Date";
                END ELSE BEGIN
                    User_Name[4] := '';
                    User_Id[4] := '';
                    User_Date[4] := 0D;
                END;

                //CSPL-00307 Start 
                Clear(Name);
                Clear(Address);
                Clear(Address2);
                Clear(City);
                Clear(PostCode);
                Clear(Country);
                IF "Requisition Header"."Global Dimension 1 Code" = '8000' then begin
                    CompInfo.Get;
                    Name := CompInfo.Name;
                    Address := CompInfo.Address;
                    Address2 := CompInfo."Address 2";
                    City := CompInfo.City;
                    PostCode := CompInfo."Post Code";
                    Country := CompInfo.County;

                end;
                IF "Requisition Header"."Global Dimension 1 Code" = '9000' then begin
                    EduSetup.Reset();
                    EduSetup.SetRange("Global Dimension 1 Code", "Requisition Header"."Global Dimension 1 Code");
                    If EduSetup.FindFirst() then;
                    Name := EduSetup."Institute Name";
                    Address := EduSetup."Institute Address";
                    Address2 := EduSetup."Institute Address 2";
                    City := EduSetup."Institute City";
                    PostCode := EduSetup."Institute Post Code";
                    Country := EduSetup."Institute Country Code";
                end;
                IF "Requisition Header"."Global Dimension 1 Code" = '9100' then begin
                    EduSetup.Reset();
                    EduSetup.SetRange("Global Dimension 1 Code", "Requisition Header"."Global Dimension 1 Code");
                    If EduSetup.FindFirst() then;
                    Name := EduSetup."Institute Name";
                    Address := EduSetup."Institute Address";
                    City := EduSetup."Institute City";
                    PostCode := EduSetup."Institute Post Code";
                    Country := EduSetup."Institute Country Code";
                    Address2 := EduSetup."Institute Address 2";
                end;
                //CSPL-00307 Ends
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

    trigger OnInitReport()
    begin
        CompInfo.GET();
        CompInfo.CALCFIELDS(Picture);
    end;

    var
        CompInfo: Record "Company Information";
        RecLocation: Record Location;
        RecUserSetup: array[6] of Record "User Setup";
        Loc_Name: Text[100];
        Loc_Add1: Text[100];
        Loc_Add2: Text[100];
        Loc_PostCode: Code[100];
        Loc_Phone: Code[30];
        Loc_City: Text[30];
        SRNo: Integer;
        Loc_GST: Text[20];
        Loc_TAN: Text[20];

        K: Integer;
        User_Id: array[6] of Text[50];
        User_Name: array[6] of Text[50];
        User_Date: array[5] of Date;
        Name: Text;
        Address: Text;
        Address2: text;
        City: Text;
        PostCode: Text;
        Country: Text;
        EduSetup: Record "Education Setup-CS";

}

