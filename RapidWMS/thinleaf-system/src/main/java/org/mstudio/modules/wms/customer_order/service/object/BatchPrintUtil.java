package org.mstudio.modules.wms.customer_order.service.object;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.NumberUtil;
import com.itextpdf.barcodes.Barcode128;
import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.geom.PageSize;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.borders.Border;
import com.itextpdf.layout.element.*;
import com.itextpdf.layout.layout.LayoutArea;
import com.itextpdf.layout.layout.LayoutContext;
import com.itextpdf.layout.layout.LayoutResult;
import com.itextpdf.layout.property.HorizontalAlignment;
import com.itextpdf.layout.property.TextAlignment;
import com.itextpdf.layout.property.UnitValue;
import com.itextpdf.layout.renderer.IRenderer;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrder;
import org.mstudio.modules.wms.stock_flow.service.object.StockFlowDTO;

import java.io.ByteArrayOutputStream;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class BatchPrintUtil {

    public static Table getTableHeaderOfBatchPrint(CustomerOrder order, PdfDocument pdfDocument, PdfFont font) {
        return getTableHeaderOfBatchPrint(order, pdfDocument, font, 1, 1,"");
    }

    public static Table getTableHeaderOfBatchPrint(CustomerOrder order, PdfDocument pdfDocument, PdfFont font, int num, int i,String flowSn) {
        Table tableHeader = new Table(6);
        tableHeader.setWidth(UnitValue.createPercentValue(100));
        tableHeader.setFontSize(11f);
        tableHeader.addCell(new Cell(1, 2).add(new Paragraph(order.getPrintTitle() + "销售单" + "(" + i + "/" + num + ")").setFont(font).setFontSize(20f)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true).setBorder(Border.NO_BORDER));
        Barcode128 barcode128 = new Barcode128(pdfDocument);
        barcode128.setCode(flowSn);
        barcode128.setSize(11f);
        tableHeader.addCell(new Cell(1, 2).add(new Image(barcode128.createFormXObject(null, null, pdfDocument)).setHorizontalAlignment(HorizontalAlignment.RIGHT)).setKeepTogether(true).setBorder(Border.NO_BORDER));

        barcode128.setCode(order.getFlowSn());
        tableHeader.addCell(new Cell(1, 2).add(new Image(barcode128.createFormXObject(null, null, pdfDocument)).setHorizontalAlignment(HorizontalAlignment.RIGHT)).setKeepTogether(true).setBorder(Border.NO_BORDER));
        tableHeader.addCell(new Cell().add(new Paragraph("购物单位:").setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
        tableHeader.addCell(new Cell(1, 2).add(new Paragraph(order.getClientName()).setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
        tableHeader.addCell(new Cell().add(new Paragraph("门店:").setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
        tableHeader.addCell(new Cell(1, 2).add(new Paragraph(order.getClientStore()).setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
        tableHeader.addCell(new Cell().add(new Paragraph("客户订单号:").setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
        tableHeader.addCell(new Cell().add(new Paragraph(order.getClientOrderSn()).setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
        tableHeader.addCell(new Cell().add(new Paragraph("客户单据号:").setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
        tableHeader.addCell(new Cell().add(new Paragraph(order.getClientOrderSn2()).setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
        tableHeader.addCell(new Cell().add(new Paragraph("制单时间:").setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
        tableHeader.addCell(new Cell().add(new Paragraph(DateUtil.format(order.getCreateTime(), "yyyy-MM-dd")).setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
        tableHeader.addCell(new Cell().add(new Paragraph("客户制单人:").setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
        tableHeader.addCell(new Cell().add(new Paragraph(order.getClientOperator()).setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
        tableHeader.addCell(new Cell().add(new Paragraph("打印时间:").setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
        tableHeader.addCell(new Cell().add(new Paragraph(DateUtil.format(new Date(), "yyyy-MM-dd")).setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
        tableHeader.addCell(new Cell().add(new Paragraph("制单人:").setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
        tableHeader.addCell(new Cell().add(new Paragraph(order.getUserCreator().getUsername()).setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
        return tableHeader;
    }

    public static void setTableBodyHeadOfBatchPrint(Table table, PdfFont font) {
        table.addHeaderCell(new Cell().add(new Paragraph("#").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
        table.addHeaderCell(new Cell().add(new Paragraph("商品条码").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
        table.addHeaderCell(new Cell().add(new Paragraph("商品名称").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
        table.addHeaderCell(new Cell().add(new Paragraph("质保日期").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true).setWidth(60f));
        table.addHeaderCell(new Cell().add(new Paragraph("规").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
        table.addHeaderCell(new Cell().add(new Paragraph("单").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
        table.addHeaderCell(new Cell().add(new Paragraph("数").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
        table.addHeaderCell(new Cell().add(new Paragraph("单价").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
        table.addHeaderCell(new Cell().add(new Paragraph("金额").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
        table.addHeaderCell(new Cell().add(new Paragraph("库位").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
        table.addHeaderCell(new Cell().add(new Paragraph("拣货").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true).setWidth(40f));
    }

    public static Table getTableFooterOfBatchPrint(CustomerOrder order, List<StockFlowDTO> stockFlowPrint, PdfFont font) {
        Long allCount = stockFlowPrint.stream().filter(f -> f.getQuantity() > 0).mapToLong(StockFlowDTO::getQuantity).sum();
        Table tableFooter = new Table(6);
        tableFooter.setWidth(UnitValue.createPercentValue(100));
        tableFooter.setFontSize(11f);
        tableFooter.addCell(new Cell(1, 6).add(new Paragraph(
                "总数量：" + NumberUtil.decimalFormat("###,##0", allCount) + " / 总金额： " + NumberUtil.decimalFormat("###,##0.00", order.getTotalPrice().doubleValue())).setFont(font).setFontSize(11f)).setTextAlignment(TextAlignment.RIGHT).setKeepTogether(true).setBorder(Border.NO_BORDER));
        tableFooter.addCell(new Cell().add(new Paragraph("备注:").setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
        tableFooter.addCell(new Cell(1, 5).add(new Paragraph(order.getDescription() == null ? "" : order.getDescription()).setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
        return tableFooter;
    }

    public static float getHeight(IElement e) {
        ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
        PdfDocument pdfDocument = new PdfDocument(new PdfWriter(outByteStream));
        Document document = new Document(pdfDocument, PageSize.A5.rotate());
        document.setMargins(0, 0, 0, 0);
        IRenderer paragraphRenderer = e.createRendererSubTree();
        LayoutResult result = paragraphRenderer.setParent(document.getRenderer()).
                layout(new LayoutContext(new LayoutArea(1, PageSize.A5.rotate())));
        return result.getOccupiedArea().getBBox().getHeight();
    }

    public static void addCell(Table table, StockFlowDTO stockFlow, PdfFont font, BigDecimal price, Long PageAllCount, int j) {
        table.addCell(new Cell().add(new Paragraph(String.valueOf(j + 1)).setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
        table.addCell(new Cell().add(new Paragraph(stockFlow.getSn()).setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
        table.addCell(new Cell().add(new Paragraph(stockFlow.getName()).setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
        table.addCell(new Cell().add(new Paragraph(stockFlow.getExpireDate() != null ? DateUtil.format(stockFlow.getExpireDate(), "yyyy-MM-dd") : "").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
        table.addCell(new Cell().add(new Paragraph(String.valueOf(stockFlow.getPackCount())).setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
        table.addCell(new Cell().add(new Paragraph(stockFlow.getUnit()).setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
        table.addCell(new Cell().add(new Paragraph(String.valueOf(stockFlow.getQuantity() > 0 ? stockFlow.getQuantity() : "")).setFont(font)).setTextAlignment(TextAlignment.RIGHT).setKeepTogether(true));
        table.addCell(new Cell().add(new Paragraph(NumberUtil.decimalFormat("###,##0.00", stockFlow.getPrice().doubleValue())).setFont(font)).setTextAlignment(TextAlignment.RIGHT).setKeepTogether(true));
        if (stockFlow.getQuantity() > 0) {
            table.addCell(new Cell().add(new Paragraph(NumberUtil.decimalFormat("###,##0.00", stockFlow.getPrice().multiply(BigDecimal.valueOf(stockFlow.getQuantity())).doubleValue())).setFont(font)).setTextAlignment(TextAlignment.RIGHT).setKeepTogether(true));
            table.addCell(new Cell().add(new Paragraph(stockFlow.getWarePositionOut().getName()).setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
            if (stockFlow.getPackCount().equals(0)) {
                table.addCell(new Cell().add(new Paragraph("").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
            } else {
                table.addCell(new Cell().add(new Paragraph(stockFlow.getQuantity() / stockFlow.getPackCount() + "件" + stockFlow.getQuantity() % stockFlow.getPackCount() + "个").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
            }
        } else {
            table.addCell(new Cell(1, 3).add(new Paragraph("缺少数量：" + (0L - stockFlow.getQuantity())).setFont(font).setFontSize(11f)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
        }
    }

    public static Table newTable(Table tableHeader, PdfFont font) {
        Table table = new Table(11);
        table.setWidth(UnitValue.createPercentValue(100));
        table.setFontSize(11f);
        table.addHeaderCell(new Cell(1, 11).add(tableHeader).setBorder(Border.NO_BORDER));
        BatchPrintUtil.setTableBodyHeadOfBatchPrint(table, font);
        return table;
    }

    public static float guessCellHeight(StockFlowDTO stockFlow, PdfFont font, BigDecimal price, Long PageAllCount, int j, Document document) {
        Table table = new Table(11);
        table.setWidth(UnitValue.createPercentValue(100));
        table.setFontSize(11f);
        setTableBodyHeadOfBatchPrint(table, font);
        addCell(table, stockFlow, font, price, PageAllCount, j);
        return getHeight(table);
    }


}
