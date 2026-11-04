.class public Lcom/adobe/air/AndroidWebView;
.super Ljava/lang/Object;
.source "AndroidWebView.java"

# interfaces
.implements Lcom/adobe/air/AndroidActivityWrapper$StateChangeCallback;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;,
        Lcom/adobe/air/AndroidWebView$WebViewCustomView;
    }
.end annotation


# static fields
.field private static final ERROR_OTHER:I = 0x0

.field private static final ERROR_PROTOCOL_UNSUPPORTED:I = 0xc9d

.field private static final FOCUS_DOWN:I = 0x3

.field private static final FOCUS_NONE:I = 0x1

.field private static final FOCUS_UP:I = 0x2

.field private static final LOG_TAG:Ljava/lang/String; = "AndroidWebView"


# instance fields
.field private mAIRSurface:Lcom/adobe/air/AIRWindowSurfaceView;

.field private mBounds:Landroid/graphics/Rect;

.field private mContext:Landroid/content/Context;

.field private mCustomViewHolder:Lcom/adobe/air/AndroidWebView$WebViewCustomView;

.field private mGlobalBounds:Landroid/graphics/Rect;

.field private mInternalReference:J

.field private mLayout:Landroid/widget/RelativeLayout;

.field private mUrl:Ljava/lang/String;

.field private mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;


# direct methods
.method public constructor <init>()V
    .locals 5

    .line 380
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    .line 1102
    iput-object v0, p0, Lcom/adobe/air/AndroidWebView;->mBounds:Landroid/graphics/Rect;

    .line 1103
    iput-object v0, p0, Lcom/adobe/air/AndroidWebView;->mGlobalBounds:Landroid/graphics/Rect;

    .line 1108
    iput-object v0, p0, Lcom/adobe/air/AndroidWebView;->mUrl:Ljava/lang/String;

    const-wide/16 v0, 0x0

    .line 381
    iput-wide v0, p0, Lcom/adobe/air/AndroidWebView;->mInternalReference:J

    .line 382
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v0

    invoke-virtual {v0}, Lcom/adobe/air/AndroidActivityWrapper;->getActivity()Landroid/app/Activity;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/AndroidWebView;->mContext:Landroid/content/Context;

    .line 383
    new-instance v0, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    iget-object v1, p0, Lcom/adobe/air/AndroidWebView;->mContext:Landroid/content/Context;

    invoke-direct {v0, p0, v1}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;-><init>(Lcom/adobe/air/AndroidWebView;Landroid/content/Context;)V

    iput-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    .line 385
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    const/4 v1, 0x1

    .line 386
    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 387
    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setBuiltInZoomControls(Z)V

    .line 388
    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setNeedInitialFocus(Z)V

    .line 391
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v2

    invoke-virtual {v2}, Lcom/adobe/air/AndroidActivityWrapper;->getWebContentsDebuggingEnabled()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 393
    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x13

    if-lt v3, v4, :cond_0

    .line 394
    iget-object v3, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-static {v2}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->setWebContentsDebuggingEnabled(Z)V

    .line 397
    :cond_0
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x12

    if-ge v2, v3, :cond_1

    .line 398
    sget-object v2, Landroid/webkit/WebSettings$PluginState;->ON:Landroid/webkit/WebSettings$PluginState;

    invoke-virtual {v0, v2}, Landroid/webkit/WebSettings;->setPluginState(Landroid/webkit/WebSettings$PluginState;)V

    .line 400
    :cond_1
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0xf

    if-le v2, v3, :cond_2

    .line 401
    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setAllowUniversalAccessFromFileURLs(Z)V

    .line 403
    :cond_2
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v0, v1}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->setScrollbarFadingEnabled(Z)V

    .line 404
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    const/high16 v1, 0x2000000

    invoke-virtual {v0, v1}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->setScrollBarStyle(I)V

    .line 411
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    new-instance v1, Lcom/adobe/air/AndroidWebView$1;

    invoke-direct {v1, p0}, Lcom/adobe/air/AndroidWebView$1;-><init>(Lcom/adobe/air/AndroidWebView;)V

    invoke-virtual {v0, v1}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    .line 471
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    new-instance v1, Lcom/adobe/air/AndroidWebView$2;

    invoke-direct {v1, p0, p0}, Lcom/adobe/air/AndroidWebView$2;-><init>(Lcom/adobe/air/AndroidWebView;Lcom/adobe/air/AndroidWebView;)V

    invoke-virtual {v0, v1}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    return-void
.end method

.method static synthetic access$000(Lcom/adobe/air/AndroidWebView;)Landroid/content/Context;
    .locals 0

    .line 56
    iget-object p0, p0, Lcom/adobe/air/AndroidWebView;->mContext:Landroid/content/Context;

    return-object p0
.end method

.method static synthetic access$100(Lcom/adobe/air/AndroidWebView;)Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;
    .locals 0

    .line 56
    iget-object p0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    return-object p0
.end method

.method static synthetic access$200(Lcom/adobe/air/AndroidWebView;)J
    .locals 2

    .line 56
    iget-wide v0, p0, Lcom/adobe/air/AndroidWebView;->mInternalReference:J

    return-wide v0
.end method

.method static synthetic access$300(Lcom/adobe/air/AndroidWebView;)Lcom/adobe/air/AIRWindowSurfaceView;
    .locals 0

    .line 56
    iget-object p0, p0, Lcom/adobe/air/AndroidWebView;->mAIRSurface:Lcom/adobe/air/AIRWindowSurfaceView;

    return-object p0
.end method

.method static synthetic access$400(Lcom/adobe/air/AndroidWebView;JI)V
    .locals 0

    .line 56
    invoke-direct {p0, p1, p2, p3}, Lcom/adobe/air/AndroidWebView;->dispatchFocusIn(JI)V

    return-void
.end method

.method static synthetic access$500(Lcom/adobe/air/AndroidWebView;JI)V
    .locals 0

    .line 56
    invoke-direct {p0, p1, p2, p3}, Lcom/adobe/air/AndroidWebView;->dispatchFocusOut(JI)V

    return-void
.end method

.method static synthetic access$600(Lcom/adobe/air/AndroidWebView;)Lcom/adobe/air/AndroidWebView$WebViewCustomView;
    .locals 0

    .line 56
    iget-object p0, p0, Lcom/adobe/air/AndroidWebView;->mCustomViewHolder:Lcom/adobe/air/AndroidWebView$WebViewCustomView;

    return-object p0
.end method

.method static synthetic access$602(Lcom/adobe/air/AndroidWebView;Lcom/adobe/air/AndroidWebView$WebViewCustomView;)Lcom/adobe/air/AndroidWebView$WebViewCustomView;
    .locals 0

    .line 56
    iput-object p1, p0, Lcom/adobe/air/AndroidWebView;->mCustomViewHolder:Lcom/adobe/air/AndroidWebView$WebViewCustomView;

    return-object p1
.end method

.method static synthetic access$800(Lcom/adobe/air/AndroidWebView;)Landroid/graphics/Rect;
    .locals 0

    .line 56
    iget-object p0, p0, Lcom/adobe/air/AndroidWebView;->mGlobalBounds:Landroid/graphics/Rect;

    return-object p0
.end method

.method private decodeURL(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .line 927
    :try_start_0
    new-instance v0, Ljava/lang/String;

    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    invoke-static {v1}, Landroid/webkit/URLUtil;->decode([B)[B

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/String;-><init>([B)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    move-object p1, v0

    :catch_0
    return-object p1
.end method

.method private native dispatchFocusIn(JI)V
.end method

.method private native dispatchFocusOut(JI)V
.end method

.method private native dispatchLoadComplete(J)V
.end method

.method private native dispatchLoadError(JLjava/lang/String;I)V
.end method

.method private native dispatchLocationChange(J)Z
.end method

.method private native dispatchLocationChanging(JLjava/lang/String;)Z
.end method

.method private refreshGlobalBounds()V
    .locals 2

    .line 826
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    if-nez v0, :cond_0

    return-void

    .line 830
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    new-instance v1, Lcom/adobe/air/AndroidWebView$3;

    invoke-direct {v1, p0}, Lcom/adobe/air/AndroidWebView$3;-><init>(Lcom/adobe/air/AndroidWebView;)V

    invoke-virtual {v0, v1}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->post(Ljava/lang/Runnable;)Z

    return-void
.end method


# virtual methods
.method public addedToStage(Lcom/adobe/air/AIRWindowSurfaceView;)V
    .locals 3

    .line 721
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mLayout:Landroid/widget/RelativeLayout;

    if-eqz v0, :cond_0

    .line 722
    invoke-virtual {p0}, Lcom/adobe/air/AndroidWebView;->removedFromStage()V

    .line 724
    :cond_0
    iput-object p1, p0, Lcom/adobe/air/AndroidWebView;->mAIRSurface:Lcom/adobe/air/AIRWindowSurfaceView;

    .line 726
    invoke-virtual {p1}, Lcom/adobe/air/AIRWindowSurfaceView;->getActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object p1

    .line 727
    invoke-virtual {p1, p0}, Lcom/adobe/air/AndroidActivityWrapper;->addActivityStateChangeListner(Lcom/adobe/air/AndroidActivityWrapper$StateChangeCallback;)V

    const/4 v0, 0x1

    .line 728
    invoke-virtual {p1, v0}, Lcom/adobe/air/AndroidActivityWrapper;->getOverlaysLayout(Z)Landroid/widget/RelativeLayout;

    move-result-object p1

    iput-object p1, p0, Lcom/adobe/air/AndroidWebView;->mLayout:Landroid/widget/RelativeLayout;

    .line 729
    iget-object p1, p0, Lcom/adobe/air/AndroidWebView;->mLayout:Landroid/widget/RelativeLayout;

    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    new-instance v1, Landroid/widget/RelativeLayout$LayoutParams;

    const/4 v2, 0x0

    invoke-direct {v1, v2, v2}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    invoke-virtual {p1, v0, v1}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    return-void
.end method

.method public adjustViewBounds(DDDD)V
    .locals 3

    .line 854
    new-instance v0, Landroid/graphics/Rect;

    double-to-int v1, p1

    double-to-int v2, p3

    add-double/2addr p1, p5

    double-to-int p1, p1

    add-double/2addr p3, p7

    double-to-int p2, p3

    invoke-direct {v0, v1, v2, p1, p2}, Landroid/graphics/Rect;-><init>(IIII)V

    iput-object v0, p0, Lcom/adobe/air/AndroidWebView;->mBounds:Landroid/graphics/Rect;

    .line 855
    iget-object p1, p0, Lcom/adobe/air/AndroidWebView;->mBounds:Landroid/graphics/Rect;

    iput-object p1, p0, Lcom/adobe/air/AndroidWebView;->mGlobalBounds:Landroid/graphics/Rect;

    .line 856
    invoke-direct {p0}, Lcom/adobe/air/AndroidWebView;->refreshGlobalBounds()V

    return-void
.end method

.method public assignFocus(I)V
    .locals 1

    const/4 v0, 0x1

    packed-switch p1, :pswitch_data_0

    goto :goto_0

    .line 1009
    :pswitch_0
    iget-object p1, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {p1, v0}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->pageDown(Z)Z

    .line 1010
    iget-object p1, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    const/16 v0, 0x82

    invoke-virtual {p1, v0}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->requestFocus(I)Z

    goto :goto_0

    .line 1004
    :pswitch_1
    iget-object p1, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {p1, v0}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->pageUp(Z)Z

    .line 1005
    iget-object p1, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    const/16 v0, 0x21

    invoke-virtual {p1, v0}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->requestFocus(I)Z

    goto :goto_0

    .line 1000
    :pswitch_2
    iget-object p1, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {p1}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->requestFocus()Z

    :goto_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public canGoBack()Z
    .locals 1

    .line 708
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->canGoBack()Z

    move-result v0

    return v0
.end method

.method public canGoForward()Z
    .locals 1

    .line 714
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->canGoForward()Z

    move-result v0

    return v0
.end method

.method public captureSnapshot(II)Landroid/graphics/Bitmap;
    .locals 4

    const/4 v0, 0x0

    if-ltz p1, :cond_2

    if-gez p2, :cond_0

    goto :goto_1

    :cond_0
    if-nez p1, :cond_1

    if-nez p2, :cond_1

    return-object v0

    .line 1039
    :cond_1
    sget-object v0, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    .line 1040
    invoke-static {p1, p2, v0}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object p1

    .line 1041
    new-instance p2, Landroid/graphics/Canvas;

    invoke-direct {p2, p1}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    .line 1044
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->getScrollX()I

    move-result v0

    neg-int v0, v0

    int-to-float v0, v0

    iget-object v1, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v1}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->getScrollY()I

    move-result v1

    neg-int v1, v1

    int-to-float v1, v1

    invoke-virtual {p2, v0, v1}, Landroid/graphics/Canvas;->translate(FF)V

    .line 1047
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->isHorizontalScrollBarEnabled()Z

    move-result v0

    .line 1048
    iget-object v1, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v1}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->isVerticalScrollBarEnabled()Z

    move-result v1

    .line 1051
    iget-object v2, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->setHorizontalScrollBarEnabled(Z)V

    .line 1052
    iget-object v2, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v2, v3}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->setVerticalScrollBarEnabled(Z)V

    .line 1057
    :try_start_0
    iget-object v2, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v2, p2}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->draw(Landroid/graphics/Canvas;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1060
    :catch_0
    iget-object v2, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v2}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->capturePicture()Landroid/graphics/Picture;

    move-result-object v2

    .line 1062
    iget-object v3, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v3}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->getScale()F

    move-result v3

    .line 1063
    invoke-virtual {p2, v3, v3}, Landroid/graphics/Canvas;->scale(FF)V

    .line 1065
    invoke-virtual {v2, p2}, Landroid/graphics/Picture;->draw(Landroid/graphics/Canvas;)V

    .line 1069
    :goto_0
    iget-object p2, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {p2, v0}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->setHorizontalScrollBarEnabled(Z)V

    .line 1070
    iget-object p2, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {p2, v1}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->setVerticalScrollBarEnabled(Z)V

    return-object p1

    :cond_2
    :goto_1
    return-object v0
.end method

.method public clearFocus()V
    .locals 1

    .line 1017
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->clearFocus()V

    .line 1018
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mAIRSurface:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v0}, Lcom/adobe/air/AIRWindowSurfaceView;->requestFocus()Z

    return-void
.end method

.method public destroyInternals()V
    .locals 2

    .line 661
    invoke-virtual {p0}, Lcom/adobe/air/AndroidWebView;->removedFromStage()V

    const-wide/16 v0, 0x0

    .line 663
    iput-wide v0, p0, Lcom/adobe/air/AndroidWebView;->mInternalReference:J

    .line 664
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->destroy()V

    const/4 v0, 0x0

    .line 665
    iput-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    return-void
.end method

.method public enableLocalDomStorage()V
    .locals 2

    .line 587
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V

    return-void
.end method

.method public getCurrentLocation()Ljava/lang/String;
    .locals 1

    .line 970
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mUrl:Ljava/lang/String;

    if-nez v0, :cond_0

    const-string v0, "about:blank"

    goto :goto_0

    .line 974
    :cond_0
    invoke-direct {p0, v0}, Lcom/adobe/air/AndroidWebView;->decodeURL(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0
.end method

.method public getMediaPlaybackRequiresUserAction()Z
    .locals 1

    .line 689
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    .line 690
    invoke-virtual {v0}, Landroid/webkit/WebSettings;->getMediaPlaybackRequiresUserGesture()Z

    move-result v0

    return v0
.end method

.method public getPageTitle()Ljava/lang/String;
    .locals 1

    .line 985
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->getTitle()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    const-string v0, ""

    :cond_0
    return-object v0
.end method

.method public goBack()V
    .locals 1

    .line 696
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->goBack()V

    return-void
.end method

.method public goForward()V
    .locals 1

    .line 702
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->goForward()V

    return-void
.end method

.method public isInTextEditingMode()Z
    .locals 1

    .line 1083
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->isInTextEditingMode()Z

    move-result v0

    return v0
.end method

.method public loadString(Ljava/lang/String;Ljava/lang/String;)V
    .locals 5

    :try_start_0
    const-string p2, "utf-8"

    .line 864
    invoke-virtual {p1, p2}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object p1

    .line 872
    array-length p2, p1

    const/4 v0, 0x2

    const/4 v1, 0x1

    const/4 v2, 0x3

    const/4 v3, 0x0

    if-lt p2, v2, :cond_0

    aget-byte p2, p1, v3

    const/16 v4, 0xef

    if-ne p2, v4, :cond_0

    aget-byte p2, p1, v1

    const/16 v4, 0xbb

    if-ne p2, v4, :cond_0

    aget-byte p2, p1, v0

    const/16 v4, 0xbf

    if-ne p2, v4, :cond_0

    const/4 p2, 0x1

    goto :goto_0

    :cond_0
    const/4 p2, 0x0

    :goto_0
    if-nez p2, :cond_1

    .line 880
    array-length p2, p1

    add-int/2addr p2, v2

    new-array p2, p2, [B

    .line 881
    array-length v4, p1

    invoke-static {p1, v3, p2, v2, v4}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    const/16 p1, -0x11

    .line 882
    aput-byte p1, p2, v3

    const/16 p1, -0x45

    .line 883
    aput-byte p1, p2, v1

    const/16 p1, -0x41

    .line 884
    aput-byte p1, p2, v0

    move-object p1, p2

    .line 889
    :cond_1
    array-length p2, p1

    invoke-static {p1, v3, p2, v0}, Landroid/util/Base64;->encodeToString([BIII)Ljava/lang/String;

    move-result-object p1

    .line 892
    iget-object p2, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    const-string v0, "text/html"

    const-string v1, "base64"

    invoke-virtual {p2, p1, v0, v1}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->loadData(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public loadURL(Ljava/lang/String;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    .line 907
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v0, p1}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->loadUrl(Ljava/lang/String;)V

    return-void
.end method

.method public onActivityStateChanged(Lcom/adobe/air/AndroidActivityWrapper$ActivityState;)V
    .locals 6

    .line 601
    :try_start_0
    const-class v0, Landroid/webkit/WebView;

    const-string v1, "isPaused"

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Class;

    invoke-virtual {v0, v1, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 602
    const-class v1, Landroid/webkit/WebView;

    const-string v3, "onResume"

    new-array v4, v2, [Ljava/lang/Class;

    invoke-virtual {v1, v3, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 603
    const-class v3, Landroid/webkit/WebView;

    const-string v4, "onPause"

    new-array v5, v2, [Ljava/lang/Class;

    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    .line 605
    iget-object v4, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    new-array v5, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v4, v5}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    .line 607
    sget-object v4, Lcom/adobe/air/AndroidWebView$4;->$SwitchMap$com$adobe$air$AndroidActivityWrapper$ActivityState:[I

    invoke-virtual {p1}, Lcom/adobe/air/AndroidActivityWrapper$ActivityState;->ordinal()I

    move-result v5

    aget v4, v4, v5

    packed-switch v4, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    if-nez v0, :cond_0

    .line 620
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->pauseTimers()V

    .line 621
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    new-array v1, v2, [Ljava/lang/Object;

    invoke-virtual {v3, v0, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    :pswitch_1
    if-eqz v0, :cond_0

    .line 611
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v1, v0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 612
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->resumeTimers()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 631
    :catch_0
    :cond_0
    :goto_0
    sget-object v0, Lcom/adobe/air/AndroidWebView$4;->$SwitchMap$com$adobe$air$AndroidActivityWrapper$ActivityState:[I

    invoke-virtual {p1}, Lcom/adobe/air/AndroidActivityWrapper$ActivityState;->ordinal()I

    move-result p1

    aget p1, v0, p1

    packed-switch p1, :pswitch_data_1

    goto :goto_1

    .line 638
    :pswitch_2
    iget-object p1, p0, Lcom/adobe/air/AndroidWebView;->mCustomViewHolder:Lcom/adobe/air/AndroidWebView$WebViewCustomView;

    if-eqz p1, :cond_1

    .line 640
    iget-object p1, p0, Lcom/adobe/air/AndroidWebView;->mCustomViewHolder:Lcom/adobe/air/AndroidWebView$WebViewCustomView;

    invoke-virtual {p1}, Lcom/adobe/air/AndroidWebView$WebViewCustomView;->onHideCustomView()V

    const/4 p1, 0x0

    .line 641
    iput-object p1, p0, Lcom/adobe/air/AndroidWebView;->mCustomViewHolder:Lcom/adobe/air/AndroidWebView$WebViewCustomView;

    goto :goto_1

    .line 634
    :pswitch_3
    iget-object p1, p0, Lcom/adobe/air/AndroidWebView;->mCustomViewHolder:Lcom/adobe/air/AndroidWebView$WebViewCustomView;

    if-nez p1, :cond_1

    .line 635
    new-instance p1, Lcom/adobe/air/AndroidWebView$WebViewCustomView;

    invoke-direct {p1, p0}, Lcom/adobe/air/AndroidWebView$WebViewCustomView;-><init>(Lcom/adobe/air/AndroidWebView;)V

    iput-object p1, p0, Lcom/adobe/air/AndroidWebView;->mCustomViewHolder:Lcom/adobe/air/AndroidWebView$WebViewCustomView;

    :cond_1
    :goto_1
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x3
        :pswitch_3
        :pswitch_2
    .end packed-switch
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 0

    return-void
.end method

.method public onLoadComplete(Ljava/lang/String;)V
    .locals 4

    .line 946
    iget-wide v0, p0, Lcom/adobe/air/AndroidWebView;->mInternalReference:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    return-void

    .line 952
    :cond_0
    iput-object p1, p0, Lcom/adobe/air/AndroidWebView;->mUrl:Ljava/lang/String;

    .line 954
    iget-wide v0, p0, Lcom/adobe/air/AndroidWebView;->mInternalReference:J

    invoke-direct {p0, v0, v1}, Lcom/adobe/air/AndroidWebView;->dispatchLoadComplete(J)V

    return-void
.end method

.method public onLoadError(Ljava/lang/String;Ljava/lang/String;I)V
    .locals 4

    .line 959
    iget-wide v0, p0, Lcom/adobe/air/AndroidWebView;->mInternalReference:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    return-void

    .line 963
    :cond_0
    iput-object p1, p0, Lcom/adobe/air/AndroidWebView;->mUrl:Ljava/lang/String;

    .line 965
    iget-wide v0, p0, Lcom/adobe/air/AndroidWebView;->mInternalReference:J

    invoke-direct {p0, v0, v1, p2, p3}, Lcom/adobe/air/AndroidWebView;->dispatchLoadError(JLjava/lang/String;I)V

    return-void
.end method

.method public onLocationChange(Ljava/lang/String;)Z
    .locals 4

    .line 912
    iget-wide v0, p0, Lcom/adobe/air/AndroidWebView;->mInternalReference:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    const/4 p1, 0x1

    return p1

    .line 918
    :cond_0
    iput-object p1, p0, Lcom/adobe/air/AndroidWebView;->mUrl:Ljava/lang/String;

    .line 920
    iget-wide v0, p0, Lcom/adobe/air/AndroidWebView;->mInternalReference:J

    invoke-direct {p0, v0, v1}, Lcom/adobe/air/AndroidWebView;->dispatchLocationChange(J)Z

    move-result p1

    return p1
.end method

.method public onLocationChanging(Ljava/lang/String;)Z
    .locals 4

    .line 934
    iget-wide v0, p0, Lcom/adobe/air/AndroidWebView;->mInternalReference:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    const/4 p1, 0x1

    return p1

    .line 941
    :cond_0
    iget-wide v0, p0, Lcom/adobe/air/AndroidWebView;->mInternalReference:J

    invoke-direct {p0, p1}, Lcom/adobe/air/AndroidWebView;->decodeURL(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, v0, v1, p1}, Lcom/adobe/air/AndroidWebView;->dispatchLocationChanging(JLjava/lang/String;)Z

    move-result p1

    return p1
.end method

.method public reload()V
    .locals 1

    .line 677
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->reload()V

    return-void
.end method

.method public removedFromStage()V
    .locals 3

    .line 735
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mLayout:Landroid/widget/RelativeLayout;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 737
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mLayout:Landroid/widget/RelativeLayout;

    iget-object v2, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v0, v2}, Landroid/widget/RelativeLayout;->removeView(Landroid/view/View;)V

    .line 738
    iput-object v1, p0, Lcom/adobe/air/AndroidWebView;->mLayout:Landroid/widget/RelativeLayout;

    .line 741
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mAIRSurface:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v0}, Lcom/adobe/air/AIRWindowSurfaceView;->getActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v0

    .line 742
    invoke-virtual {v0}, Lcom/adobe/air/AndroidActivityWrapper;->didRemoveOverlay()V

    .line 743
    invoke-virtual {v0, p0}, Lcom/adobe/air/AndroidActivityWrapper;->removeActivityStateChangeListner(Lcom/adobe/air/AndroidActivityWrapper$StateChangeCallback;)V

    .line 745
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mAIRSurface:Lcom/adobe/air/AIRWindowSurfaceView;

    const/4 v2, 0x0

    invoke-virtual {v0, p0, v2}, Lcom/adobe/air/AIRWindowSurfaceView;->updateFocusedStageWebView(Lcom/adobe/air/AndroidWebView;Z)V

    .line 748
    :cond_0
    iput-object v1, p0, Lcom/adobe/air/AndroidWebView;->mAIRSurface:Lcom/adobe/air/AIRWindowSurfaceView;

    return-void
.end method

.method public resetGlobalBounds()V
    .locals 1

    .line 821
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mBounds:Landroid/graphics/Rect;

    iput-object v0, p0, Lcom/adobe/air/AndroidWebView;->mGlobalBounds:Landroid/graphics/Rect;

    .line 822
    invoke-direct {p0}, Lcom/adobe/air/AndroidWebView;->refreshGlobalBounds()V

    return-void
.end method

.method public setInternalReference(J)V
    .locals 0

    .line 655
    iput-wide p1, p0, Lcom/adobe/air/AndroidWebView;->mInternalReference:J

    return-void
.end method

.method public setMediaPlaybackRequiresUserAction(Z)V
    .locals 3

    const-string v0, "AndroidWebView"

    .line 682
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Java - setting val = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 683
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    .line 684
    invoke-virtual {v0, p1}, Landroid/webkit/WebSettings;->setMediaPlaybackRequiresUserGesture(Z)V

    return-void
.end method

.method public setStageFocus(I)V
    .locals 1

    .line 1024
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->clearFocus()V

    .line 1025
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mAIRSurface:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v0, p1}, Lcom/adobe/air/AIRWindowSurfaceView;->requestFocus(I)Z

    return-void
.end method

.method public setVisibility(Z)V
    .locals 1

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    const/4 p1, 0x4

    .line 755
    :goto_0
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->getVisibility()I

    move-result v0

    if-eq v0, p1, :cond_1

    .line 758
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v0, p1}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->setVisibility(I)V

    :cond_1
    return-void
.end method

.method public stop()V
    .locals 1

    .line 671
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mView:Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidWebView$AndroidWebViewImpl;->stopLoading()V

    return-void
.end method

.method public updateViewBoundsWithKeyboard(I)J
    .locals 5

    .line 765
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mBounds:Landroid/graphics/Rect;

    iput-object v0, p0, Lcom/adobe/air/AndroidWebView;->mGlobalBounds:Landroid/graphics/Rect;

    .line 767
    iget-object v0, p0, Lcom/adobe/air/AndroidWebView;->mAIRSurface:Lcom/adobe/air/AIRWindowSurfaceView;

    const/4 v1, 0x0

    if-eqz v0, :cond_3

    invoke-virtual {p0}, Lcom/adobe/air/AndroidWebView;->isInTextEditingMode()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 770
    new-instance v0, Landroid/graphics/Rect;

    iget-object v2, p0, Lcom/adobe/air/AndroidWebView;->mAIRSurface:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v2}, Lcom/adobe/air/AIRWindowSurfaceView;->getVisibleBoundWidth()I

    move-result v2

    iget-object v3, p0, Lcom/adobe/air/AndroidWebView;->mAIRSurface:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v3}, Lcom/adobe/air/AIRWindowSurfaceView;->getVisibleBoundHeight()I

    move-result v3

    invoke-direct {v0, v1, v1, v2, v3}, Landroid/graphics/Rect;-><init>(IIII)V

    .line 771
    iget-object v2, p0, Lcom/adobe/air/AndroidWebView;->mBounds:Landroid/graphics/Rect;

    invoke-virtual {v0, v2}, Landroid/graphics/Rect;->contains(Landroid/graphics/Rect;)Z

    move-result v2

    if-nez v2, :cond_3

    .line 776
    iget-object v2, p0, Lcom/adobe/air/AndroidWebView;->mBounds:Landroid/graphics/Rect;

    iget v2, v2, Landroid/graphics/Rect;->top:I

    invoke-static {v1, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    invoke-static {v2, p1}, Ljava/lang/Math;->min(II)I

    move-result v2

    .line 777
    iget-object v3, p0, Lcom/adobe/air/AndroidWebView;->mBounds:Landroid/graphics/Rect;

    iget v3, v3, Landroid/graphics/Rect;->bottom:I

    invoke-static {v1, v3}, Ljava/lang/Math;->max(II)I

    move-result v1

    invoke-static {v1, p1}, Ljava/lang/Math;->min(II)I

    move-result p1

    const-wide/16 v3, 0x0

    if-ne v2, p1, :cond_0

    return-wide v3

    .line 786
    :cond_0
    iget v1, v0, Landroid/graphics/Rect;->bottom:I

    sub-int v1, p1, v1

    if-gtz v1, :cond_1

    return-wide v3

    :cond_1
    if-gt v1, v2, :cond_2

    goto :goto_0

    .line 807
    :cond_2
    new-instance p1, Landroid/graphics/Rect;

    iget-object v1, p0, Lcom/adobe/air/AndroidWebView;->mBounds:Landroid/graphics/Rect;

    invoke-direct {p1, v1}, Landroid/graphics/Rect;-><init>(Landroid/graphics/Rect;)V

    iput-object p1, p0, Lcom/adobe/air/AndroidWebView;->mGlobalBounds:Landroid/graphics/Rect;

    .line 808
    iget-object p1, p0, Lcom/adobe/air/AndroidWebView;->mGlobalBounds:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->bottom:I

    add-int/2addr v0, v2

    iput v0, p1, Landroid/graphics/Rect;->bottom:I

    move v1, v2

    .line 814
    :cond_3
    :goto_0
    invoke-direct {p0}, Lcom/adobe/air/AndroidWebView;->refreshGlobalBounds()V

    int-to-long v0, v1

    return-wide v0
.end method
