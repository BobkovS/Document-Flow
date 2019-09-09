from docx import Document
from docx.enum.text import WD_PARAGRAPH_ALIGNMENT


def generate_report(data):
    document = Document()

    head = document.add_heading(
        'Квитанция на оплату закупок компанией "{}" с {} по {}'.format(data['Компания'], data['Дата начала отсчета'],
                                                                       data['Дата конца отсчета']), 0)
    head.alignment = WD_PARAGRAPH_ALIGNMENT.CENTER

    p = document.add_paragraph('Уважаемый(ая) ')
    p.alignment = WD_PARAGRAPH_ALIGNMENT.CENTER
    p.add_run(data['Фамилия'] + ' ' + data['Имя'] + ' ' + data['Отчество'] + ' ').bold = True
    p.add_run('просим вас оплатить закупки вашей компанией ')
    p.add_run('"' + data['Компания'] + '"' + ' ').bold = True
    p.add_run('в период с ')
    p.add_run(data['Дата начала отсчета'] + ' ').bold = True
    p.add_run('по ')
    p.add_run(data['Дата конца отсчета'] + '.').bold = True

    document.add_paragraph()
    document.add_paragraph('Прилагаю список товаров')
    records = (
        (3, '101', 'Spam'),
        (7, '422', 'Eggs'),
        (4, '631', 'Spam, spam, eggs, and spam')
    )

    table = document.add_table(rows=1, cols=3)
    hdr_cells = table.rows[0].cells
    hdr_cells[0].text = 'Qty'
    hdr_cells[1].text = 'Id'
    hdr_cells[2].text = 'Desc'
    for qty, id, desc in records:
        row_cells = table.add_row().cells
        row_cells[0].text = str(qty)
        row_cells[1].text = id
        row_cells[2].text = desc

    document.add_page_break()

    document.save('demo.docx')
