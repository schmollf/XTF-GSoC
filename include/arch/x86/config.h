#ifndef XTF_X86_CONFIG_H
#define XTF_X86_CONFIG_H

#if defined(CONFIG_ENV_pv64) || defined(CONFIG_ENV_pv32pae)
# define CONFIG_PV
#elif defined(CONFIG_ENV_hvm64) || defined(CONFIG_ENV_hvm32pae)
# define CONFIG_HVM
#endif

#endif /* XTF_X86_CONFIG_H */

/*
 * Local variables:
 * mode: C
 * c-file-style: "BSD"
 * c-basic-offset: 4
 * tab-width: 4
 * indent-tabs-mode: nil
 * End:
 */
