import { createInertiaApp } from "@inertiajs/react";
import { createElement } from "react";
import { createRoot } from "react-dom/client";
import AppLayout from "~/layouts/AppLayout";

const APP_NAME = "{{APP_NAME}}";

createInertiaApp({
  title: (title) => title ? `${title} | ${APP_NAME}` : APP_NAME,

  resolve: (name) => {
    const pages = import.meta.glob("~/pages/**/*.jsx", { eager: true });
    const page = Object.values(pages).find((page) => page.default.name === name);
    if (page && !page.default.layout) {
      page.default.layout = p => <AppLayout children={p} />;
    }
    return page ? page.default : null;
  },

  setup({ el, App, props }) {
    const root = createRoot(el);
    root.render(<App {...props} />);
  },
})
