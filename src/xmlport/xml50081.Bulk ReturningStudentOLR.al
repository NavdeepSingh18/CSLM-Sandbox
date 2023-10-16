xmlport 50081 "Bulk Returning Student OLR"
{
    Direction = Import;
    Format = VariableText;
    FieldSeparator = ',';
    UseRequestPage = false;

    schema
    {
        textelement(root)
        {
            tableelement(OLRUpdateLine; "OLR Update Line")
            {
                AutoSave = false;
                fieldattribute(Enrollment_No; OLRUpdateLine."Enrollment No.")
                {

                }
                fieldattribute(AcademicYear; OLRUpdateLine."OLR Academic Year")
                {

                }
                fieldattribute(Semster; OLRUpdateLine."OLR Semester")
                {

                }
                fieldattribute(Term; OLRUpdateLine."OLR Term")
                {

                }

                trigger OnAfterInitRecord()
                begin
                    myInt += 1;
                end;

                trigger OnBeforeInsertRecord()
                begin
                    if OLRUpdateLine."Enrollment No." = '' then
                        Error('%1 must have a value in the file.', OLRUpdateLine.FieldCaption("Enrollment No."));
                    if OLRUpdateLine."OLR Academic Year" = '' then
                        Error('%1 must have a value in the file.', OLRUpdateLine.FieldCaption("OLR Academic Year"));
                    if OLRUpdateLine."OLR Semester" = '' then
                        Error('%1 must have a value in the file.', OLRUpdateLine.FieldCaption("OLR Semester"));
                    if not (OLRUpdateLine."OLR Term" in [OLRUpdateLine."OLR Term"::FALL, OLRUpdateLine."OLR Term"::SPRING, OLRUpdateLine."OLR Term"::SUMMER]) then
                        Error('%1 must have a value in the file.', OLRUpdateLine.FieldCaption("OLR Term"));
                end;

                trigger OnAfterInsertRecord()
                var
                    SemsterMaster: Record "Semester Master-CS";
                begin
                    SemsterMaster.Reset();
                    SemsterMaster.SetRange(Code, OLRUpdateLine."OLR Semester");
                    SemsterMaster.FindFirst();

                    studentmaster.Reset();
                    studentmaster.SetRange("Enrollment No.", OLRUpdateLine."Enrollment No.");
                    studentmaster.FindFirst();

                    olrapplicationline.Reset();
                    olrapplicationline.SetRange("Document No.", olrapplicationheader."No.");
                    if olrapplicationline.findlast() then
                        olrapplicationline."Line No." += 10000
                    else
                        olrapplicationline."Line No." := 10000;

                    olrapplicationline.Reset();
                    olrapplicationline.SetRange("Student No.", studentmaster."No.");
                    olrapplicationline.SetRange("OLR Semester", OLRUpdateLine."OLR Semester");
                    olrapplicationline.SetRange("OLR Academic Year", OLRUpdateLine."OLR Academic Year");
                    olrapplicationline.SetRange("OLR Term", OLRUpdateLine."OLR Term");
                    If not olrapplicationline.FindFirst() then begin
                        if myInt = 1 then begin
                            olrapplicationheader.Reset();
                            olrapplicationheader.Init();
                            olrapplicationheader."No." := noseriesmgt.GetNextNo(educationsetup."OLR Update Application Nos.", today, true);
                            olrapplicationheader."No. Series" := educationsetup."OLR Update Application Nos.";
                            //olrapplicationheader."Global Dimension 1 Code" := educationsetup."Global Dimension 1 Code";
                            olrapplicationheader.Insert(true);
                        end;
                        olrapplicationline.Init();
                        olrapplicationline."Document No." := olrapplicationheader."No.";
                        olrapplicationline."Olr Academic Year" := OLRUpdateLine."OLR Academic Year";
                        olrapplicationline."OLR Semester" := OLRUpdateLine."OLR Semester";
                        olrapplicationline."OLR Term" := OLRUpdateLine."OLR Term";
                        olrapplicationline."Student No." := studentmaster."No.";
                        olrapplicationline."Original Student No." := studentmaster."Original Student No.";
                        olrapplicationline."Student Name" := studentmaster."First Name" + ' ' + studentmaster."Last Name";
                        olrapplicationline."Course Code" := studentmaster."Course Code";
                        olrapplicationline.Semester := studentmaster.Semester;
                        olrapplicationline.Status := studentmaster.Status;
                        olrapplicationline."Enrollment No." := studentmaster."Enrollment No.";
                        olrapplicationline."Academic Year" := studentmaster."Academic Year";
                        olrapplicationline.Term := studentmaster.Term;
                        olrapplicationline."OLR Start Date" := Today();
                        olrapplicationline."Global Dimension 1 Code" := studentmaster."Global Dimension 1 Code";
                        olrapplicationline.Insert(true);
                        // olrapplicationheader."Academic Year" := olrapplicationline."Academic Year";
                        // olrapplicationheader.Term := olrapplicationline.Term;
                        olrapplicationheader."OLR Academic Year" := educationsetup."Returning OLR Academic Year";
                        olrapplicationheader."OLR Term" := educationsetup."Returning OLR Term";
                        olrapplicationheader.Modify(true);
                    end;
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {

                }
            }
        }
    }

    var

        educationsetup: Record "Education Setup-CS";
        olrapplicationheader: Record "OLR Update Header";
        olrapplicationline: Record "OLR Update Line";
        studentmaster: Record "Student Master-CS";
        noseriesmgt: Codeunit NoSeriesManagement;
        myInt: Integer;

    trigger OnPreXmlPort()
    begin
        myInt := 0;
        // educationsetup.Get('AUA2021');
        educationsetup.Reset();
        educationsetup.SetRange("Global Dimension 1 Code", '9000');
        IF educationsetup.FindFirst() then
            educationsetup.TestField("OLR Update Application Nos.");
    end;

    trigger OnPostXmlPort()
    begin
        Message(StrSubstNo('Uploaded Successfully with OLR Application No. %1.', olrapplicationheader."No."));
    end;
}